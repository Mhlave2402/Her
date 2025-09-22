<?php

namespace Modules\TripManagement\Http\Controllers\Api\New\Driver;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\TripManagement\Entities\TripRequest;
use Illuminate\Support\Facades\Validator;
use Modules\TripManagement\Events\TripRequested;

class TripRequestController extends Controller
{
    public function show($trip_id)
    {
        $trip = TripRequest::find($trip_id);

        if (!$trip) {
            return response()->json(['message' => 'Trip not found'], 404);
        }

        return response()->json($trip);
    }

    public function accept(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'trip_id' => 'required|exists:trip_requests,id',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $trip = TripRequest::find($request->trip_id);
        $trip->current_status = 'accepted';
        $trip->driver_id = auth()->id();
        $trip->save();

        return response()->json(['message' => 'Trip accepted successfully']);
    }

    public function decline(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'trip_id' => 'required|exists:trip_requests,id',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 422);
        }

        $trip = TripRequest::find($request->trip_id);
        $trip->current_status = 'cancelled';
        $trip->save();

        // Find the next available driver
        // This is a placeholder for the actual logic
        $nextDriver = null; 

        if ($nextDriver) {
            event(new TripRequested($trip, $nextDriver));
        }

        return response()->json(['message' => 'Trip declined successfully']);
    }
}
