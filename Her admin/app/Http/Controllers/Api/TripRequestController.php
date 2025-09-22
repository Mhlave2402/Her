<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Modules\TripManagement\Entities\TripRequest;

class TripRequestController extends Controller
{
    public function updateWithMaleCompanion(Request $request, $tripId)
    {
        $request->validate([
            'with_male_companion' => 'required|boolean',
        ]);

        $trip = TripRequest::findOrFail($tripId);

        // Check if user is the trip owner
        if ($trip->customer_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $trip->with_male_companion = $request->with_male_companion;
        $trip->save();

        return response()->json($trip);
    }

    public function updateIsChildFriendly(Request $request, $tripId)
    {
        $request->validate([
            'is_child_friendly' => 'required|boolean',
        ]);

        $trip = TripRequest::findOrFail($tripId);

        // Check if user is the trip owner
        if ($trip->customer_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $trip->vehicle->is_child_friendly = $request->is_child_friendly;
        $trip->vehicle->save();

        return response()->json($trip);
    }

    public function requestNannyRide(Request $request, $tripId)
    {
        $request->validate([
            'is_nanny_ride' => 'required|boolean',
        ]);

        $trip = TripRequest::findOrFail($tripId);

        if ($trip->customer_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $trip->is_nanny_ride = $request->is_nanny_ride;

        if ($request->is_nanny_ride) {
            $driver = $trip->driver;
            if ($driver && $driver->is_nanny) {
                $trip->fee += $driver->nanny_service_fee;
            }
        }

        $trip->save();

        return response()->json($trip);
    }

    public function requestKidsOnlyRide(Request $request, $tripId)
    {
        $request->validate([
            'is_kids_only_ride' => 'required|boolean',
        ]);

        $trip = TripRequest::findOrFail($tripId);

        if ($trip->customer_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $trip->is_kids_only_ride = $request->is_kids_only_ride;

        if ($request->is_kids_only_ride) {
            $driver = $trip->driver;
            if ($driver && $driver->is_kids_only_verified) {
                $trip->fee += $driver->kids_only_service_fee;
            }
        }

        $trip->save();

        return response()->json($trip);
    }
}
