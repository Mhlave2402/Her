<?php

namespace App\Http\Controllers\Api\V1;

use App\Http\Controllers\Controller;
use App\Service\FeatureFeeService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class FeeController extends Controller
{
    protected $feeService;

    public function __construct(FeatureFeeService $feeService)
    {
        $this->feeService = $feeService;
    }

    public function getApplicableFees(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'zone_id' => 'required|uuid',
            'vehicle_type' => 'required|string',
            'fare' => 'required|numeric',
            'distance' => 'required|numeric',
            'duration' => 'required|numeric',
            'features' => 'required|array',
            'features.*' => 'string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $tripData = $request->only(['zone_id', 'vehicle_type', 'fare', 'distance', 'duration']);
        // Assume base_fare is the same as fare for now, can be adjusted
        $tripData['base_fare'] = $request->fare; 
        
        $selectedFeatures = $request->features;

        $feeResults = $this->feeService->calculateFeesForTrip($tripData, $selectedFeatures);

        return response()->json($feeResults);
    }
}
