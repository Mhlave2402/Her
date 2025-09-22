<?php

namespace Modules\ZoneManagement\Http\Controllers\Api\New\Customer;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\ZoneManagement\Entities\Zone;

class ZoneController extends Controller
{
    public function getZone(Request $request)
    {
        $request->validate([
            'type' => 'required|in:user,driver'
        ]);

        $user = $request->user();
        $zone = Zone::where('id', $user->zone_id)->first();

        if (!$zone) {
            return response()->json(['message' => 'Zone not found.'], 404);
        }

        return response()->json(['zone' => $zone]);
    }
}
