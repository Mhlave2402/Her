<?php

namespace Modules\TripManagement\Http\Controllers\Api\New\Customer;

use App\Models\SharedTripLink;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Str;
use Modules\TripManagement\Entities\TripRequest;

class SharedTripLinkController extends Controller
{
    public function store(Request $request, TripRequest $tripRequest)
    {
        $token = Str::random(40);

        $link = SharedTripLink::create([
            'trip_request_id' => $tripRequest->id,
            'token' => $token,
            'expires_at' => now()->addHours(24),
        ]);

        return response()->json([
            'sharing_link' => url('/trip/share/' . $link->token),
        ]);
    }
}
