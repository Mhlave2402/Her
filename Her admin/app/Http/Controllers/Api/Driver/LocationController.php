<?php

namespace App\Http\Controllers\Api\Driver;

use App\Events\DriverLocationUpdated;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Modules\TripManagement\Entities\TripRequest;

class LocationController extends Controller
{
    public function update(Request $request, TripRequest $tripRequest)
    {
        // You would typically get the driver's location from the request
        // and update the trip request or a related model.
        // For this example, we'll just broadcast the event.

        broadcast(new DriverLocationUpdated($tripRequest))->toOthers();

        return response()->json(['status' => 'success']);
    }
}
