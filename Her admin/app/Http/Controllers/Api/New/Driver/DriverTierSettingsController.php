<?php

namespace App\Http\Controllers\Api\New\Driver;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Modules\UserManagement\Entities\User;
use Modules\VehicleManagement\Entities\Vehicle;
use App\Models\DriverTierPreference;

class DriverTierSettingsController extends Controller
{
    public function getTierSettings()
    {
        $driver = Auth::user();

        $vehicles = Vehicle::where('driver_id', $driver->id)->get();

        $global_preferences = DriverTierPreference::where('driver_id', $driver->id)
            ->whereNull('vehicle_id')
            ->get()
            ->keyBy('tier_key');

        $per_vehicle_preferences = DriverTierPreference::where('driver_id', $driver->id)
            ->whereNotNull('vehicle_id')
            ->get()
            ->groupBy('vehicle_id')
            ->map(function ($group) {
                return $group->keyBy('tier_key');
            });

        return response()->json([
            'driver' => [
                'id' => $driver->id,
                'registered_tier' => $driver->registered_tier,
                'is_verified_female' => $driver->is_verified_female,
            ],
            'vehicles' => $vehicles,
            'preferences' => [
                'global' => $global_preferences,
                'per_vehicle' => $per_vehicle_preferences,
            ],
        ]);
    }

    public function updateTierSettings(Request $request)
    {
        $driver = Auth::user();

        $request->validate([
            'global' => 'sometimes|array',
            'per_vehicle' => 'sometimes|array',
        ]);

        if ($request->has('global')) {
            foreach ($request->global as $tier_key => $is_enabled) {
                if ($tier_key === $driver->registered_tier && !$is_enabled) {
                    return response()->json(['message' => 'You cannot disable your registered tier.'], 422);
                }

                DriverTierPreference::updateOrCreate(
                    ['driver_id' => $driver->id, 'vehicle_id' => null, 'tier_key' => $tier_key],
                    ['is_enabled' => $is_enabled]
                );
            }
        }

        if ($request->has('per_vehicle')) {
            foreach ($request->per_vehicle as $vehicle_id => $preferences) {
                $vehicle = Vehicle::where('id', $vehicle_id)->where('driver_id', $driver->id)->first();

                if (!$vehicle) {
                    return response()->json(['message' => 'Invalid vehicle.'], 422);
                }

                foreach ($preferences as $tier_key => $is_enabled) {
                    if ($tier_key === $vehicle->vehicle_tier && !$is_enabled) {
                        return response()->json(['message' => 'You cannot disable your registered tier.'], 422);
                    }

                    DriverTierPreference::updateOrCreate(
                        ['driver_id' => $driver->id, 'vehicle_id' => $vehicle_id, 'tier_key' => $tier_key],
                        ['is_enabled' => $is_enabled]
                    );
                }
            }
        }

        return response()->json(['status' => 'ok', 'updated_at' => now()]);
    }
}
