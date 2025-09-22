<?php

namespace App\Service;

use App\Models\FeatureFeeConfig;
use Carbon\Carbon;

class FeatureFeeService
{
    public function getApplicableConfigs($zoneId, $vehicleType, $features)
    {
        $now = Carbon::now();

        return FeatureFeeConfig::where('is_active', true)
            ->where(function ($query) use ($now) {
                $query->whereNull('start_at')->orWhere('start_at', '<=', $now);
            })
            ->where(function ($query) use ($now) {
                $query->whereNull('end_at')->orWhere('end_at', '>=', $now);
            })
            ->whereIn('feature_key', $features)
            ->where(function ($query) use ($zoneId) {
                $query->where('zone_id', $zoneId)->orWhereNull('zone_id');
            })
            ->where(function ($query) use ($vehicleType) {
                $query->where('vehicle_type', $vehicleType)->orWhereNull('vehicle_type');
            })
            ->orderBy('priority', 'desc')
            ->get();
    }

    public function calculateFeesForTrip($tripData, $selectedFeatures)
    {
        $configs = $this->getApplicableConfigs(
            $tripData['zone_id'],
            $tripData['vehicle_type'],
            $selectedFeatures
        );

        $appliedFees = [];
        $totalFeatureFees = 0;

        // Eager load zone to get currency
        $configs->load('zone');

        foreach ($configs as $config) {
            // Skip if a fee for this feature has already been calculated with a higher priority
            if (isset($appliedFees[$config->feature_key])) {
                continue;
            }

            $fee = $this->calculateFee($config, $tripData);

            if ($fee > 0) {
                $appliedFees[$config->feature_key] = [
                    'feature_key' => $config->feature_key,
                    'config_id' => $config->id,
                    'model' => $config->pricing_model,
                    'amount' => round($fee, 2),
                    'currency' => $config->zone->currency_code ?? 'ZAR', // Default currency
                    'display_label' => $this->getDisplayLabel($config->feature_key),
                ];
                $totalFeatureFees += $fee;
            }
        }

        return [
            'applied_fees' => array_values($appliedFees),
            'total_feature_fees' => round($totalFeatureFees, 2),
            'fare_with_features' => $tripData['fare'] + round($totalFeatureFees, 2),
        ];
    }

    private function calculateFee($config, $tripData)
    {
        $fee = 0;

        switch ($config->pricing_model) {
            case 'flat':
                $fee = $config->value;
                break;
            case 'percentage':
                $base = ($config->apply_on == 'fare_total') ? $tripData['fare'] : $tripData['base_fare'];
                $fee = ($base * $config->value) / 100;
                break;
            case 'per_km':
                $fee = $tripData['distance'] * $config->value;
                break;
            case 'per_min':
                $fee = ($tripData['duration'] / 60) * $config->value;
                break;
            case 'tiered':
                $fee = $this->calculateTieredFee($config, $tripData);
                break;
        }

        if ($config->min_fee && $fee < $config->min_fee) {
            $fee = $config->min_fee;
        }

        if ($config->max_fee && $fee > $config->max_fee) {
            $fee = $config->max_fee;
        }

        return $fee;
    }

    private function calculateTieredFee($config, $tripData)
    {
        $tierConfig = $config->tier_config; // Already an array due to model casting
        $tiers = $tierConfig['tiers'] ?? [];
        $unit = $tierConfig['unit'] ?? 'distance';
        $value = ($unit === 'distance') ? $tripData['distance'] : ($tripData['duration'] / 60);

        // Sort tiers by max value to handle them correctly
        usort($tiers, function ($a, $b) {
            return ($a['max'] ?? PHP_INT_MAX) <=> ($b['max'] ?? PHP_INT_MAX);
        });

        foreach ($tiers as $tier) {
            $max = $tier['max'] ?? null;
            if ($max === null || $value <= $max) {
                return $tier['fee'];
            }
        }

        return 0;
    }

    private function getDisplayLabel($featureKey)
    {
        $labels = [
            'male_companion' => 'Male Companion Fee',
            'child_mode' => 'Child-Friendly Mode Fee',
            'nanny_ride' => 'Nanny Ride Fee',
            'kids_only' => 'Kids-Only Verified Ride Fee',
            'baby_seat' => 'Baby Seat Fee',
        ];

        return $labels[$featureKey] ?? ucfirst(str_replace('_', ' ', $featureKey)) . ' Fee';
    }

    public function lockFeesOnTripCreation($trip, $feeResults)
    {
        foreach ($feeResults['applied_fees'] as $fee) {
            $trip->featureCharges()->create([
                'feature_key' => $fee['feature_key'],
                'amount' => $fee['amount'],
                'applied_by_config_id' => $fee['config_id'],
                'applied_at' => now(),
            ]);
        }
    }
}
