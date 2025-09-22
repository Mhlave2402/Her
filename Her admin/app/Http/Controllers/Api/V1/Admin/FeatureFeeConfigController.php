<?php

namespace App\Http\Controllers\Api\V1\Admin;

use App\Http\Controllers\Controller;
use App\Models\FeatureFeeConfig;
use App\Models\FeatureFeeAuditLog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class FeatureFeeConfigController extends Controller
{
    public function index(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'zone_id' => 'sometimes|uuid',
            'vehicle_type' => 'sometimes|string',
            'is_active' => 'sometimes|boolean',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $query = FeatureFeeConfig::with(['zone', 'createdBy', 'updatedBy']);

        if ($request->filled('zone_id')) {
            $query->where('zone_id', $request->zone_id);
        }

        if ($request->filled('vehicle_type')) {
            $query->where('vehicle_type', $request->vehicle_type);
        }

        if ($request->filled('is_active')) {
            $query->where('is_active', $request->is_active);
        }

        $configs = $query->latest()->paginate(10);

        return response()->json($configs);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'feature_key' => 'required|string',
            'zone_id' => 'nullable|uuid|exists:zones,id',
            'vehicle_type' => 'nullable|string',
            'pricing_model' => 'required|in:flat,percentage,per_km,per_min,tiered',
            'value' => 'required_unless:pricing_model,tiered|numeric',
            'tier_config' => 'required_if:pricing_model,tiered|json',
            'min_fee' => 'nullable|numeric',
            'max_fee' => 'nullable|numeric',
            'apply_on' => 'nullable|in:base_fare,fare_total',
            'start_at' => 'nullable|date',
            'end_at' => 'nullable|date|after_or_equal:start_at',
            'is_active' => 'required|boolean',
            'priority' => 'required|integer',
            'payout_rule' => 'nullable|json',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $data = $request->all();
        $data['created_by'] = Auth::id();
        $data['updated_by'] = Auth::id();

        $config = FeatureFeeConfig::create($data);

        $this->logAudit(null, $config, Auth::user());

        return response()->json($config, 201);
    }

    public function show(FeatureFeeConfig $featureFeeConfig)
    {
        $featureFeeConfig->load(['zone', 'createdBy', 'updatedBy']);
        return response()->json($featureFeeConfig);
    }

    public function update(Request $request, FeatureFeeConfig $featureFeeConfig)
    {
        $validator = Validator::make($request->all(), [
            'feature_key' => 'sometimes|required|string',
            'zone_id' => 'nullable|uuid|exists:zones,id',
            'vehicle_type' => 'nullable|string',
            'pricing_model' => 'sometimes|required|in:flat,percentage,per_km,per_min,tiered',
            'value' => 'sometimes|required_unless:pricing_model,tiered|numeric',
            'tier_config' => 'sometimes|required_if:pricing_model,tiered|json',
            'min_fee' => 'nullable|numeric',
            'max_fee' => 'nullable|numeric',
            'apply_on' => 'nullable|in:base_fare,fare_total',
            'start_at' => 'nullable|date',
            'end_at' => 'nullable|date|after_or_equal:start_at',
            'is_active' => 'sometimes|required|boolean',
            'priority' => 'sometimes|required|integer',
            'payout_rule' => 'nullable|json',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $before = $featureFeeConfig->getOriginal();

        $data = $request->all();
        $data['updated_by'] = Auth::id();

        $featureFeeConfig->update($data);

        $this->logAudit($before, $featureFeeConfig, Auth::user());

        return response()->json($featureFeeConfig);
    }

    public function destroy(FeatureFeeConfig $featureFeeConfig)
    {
        $this->logAudit($featureFeeConfig->getOriginal(), null, Auth::user());
        $featureFeeConfig->delete();

        return response()->json(null, 204);
    }

    public function auditLogs($configId)
    {
        $logs = FeatureFeeAuditLog::with('user')
            ->where('feature_fee_config_id', $configId)
            ->latest('changed_at')
            ->paginate(10);

        return response()->json($logs);
    }

    protected function logAudit($before, $after, $user)
    {
        FeatureFeeAuditLog::create([
            'feature_fee_config_id' => $after ? $after->id : $before['id'],
            'user_id' => $user->id,
            'before' => $before,
            'after' => $after ? $after->toArray() : null,
            'changed_at' => now(),
        ]);
    }
}
