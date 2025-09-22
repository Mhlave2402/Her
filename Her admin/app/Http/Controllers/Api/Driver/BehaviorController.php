<?php

namespace App\Http\Controllers\Api\Driver;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\DriverBehavior;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class BehaviorController extends Controller
{
    public function storeSpeedingEvent(Request $request)
    {
        $request->validate([
            'threshold_exceeded' => 'required|numeric',
            'trip_id' => 'nullable|exists:trips,id',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
        ]);

        DriverBehavior::create([
            'driver_id' => Auth::id(),
            'trip_id' => $request->trip_id,
            'event_type' => 'speeding',
            'threshold_exceeded' => $request->threshold_exceeded,
            'location' => DB::raw("POINT({$request->latitude}, {$request->longitude})"),
        ]);

        return response()->json(['message' => 'Speeding event stored successfully.']);
    }

    public function storeHardBrakingEvent(Request $request)
    {
        $request->validate([
            'threshold_exceeded' => 'required|numeric',
            'trip_id' => 'nullable|exists:trips,id',
            'latitude' => 'required|numeric',
            'longitude' => 'required|numeric',
        ]);

        DriverBehavior::create([
            'driver_id' => Auth::id(),
            'trip_id' => $request->trip_id,
            'event_type' => 'hard_braking',
            'threshold_exceeded' => $request->threshold_exceeded,
            'location' => DB::raw("POINT({$request->latitude}, {$request->longitude})"),
        ]);

        return response()->json(['message' => 'Hard braking event stored successfully.']);
    }
}
