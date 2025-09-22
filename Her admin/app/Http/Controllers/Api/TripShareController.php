<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SharedTripLink;
use Illuminate\Http\Request;

class TripShareController extends Controller
{
    public function show($token)
    {
        $link = SharedTripLink::where('token', $token)->where('expires_at', '>', now())->firstOrFail();
        $trip = $link->tripRequest;

        return view('trip-share', compact('trip'));
    }
}
