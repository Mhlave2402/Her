<?php

namespace Modules\SOSManagement\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\SOSManagement\Entities\SOS;
use App\Events\SOSAlert;

class SOSController extends Controller
{
    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'latitude' => 'required',
            'longitude' => 'required',
        ]);

        $sos = new SOS();
        $sos->user_id = $request->user()->id;
        $sos->trip_id = $request->trip_id;
        $sos->latitude = $request->latitude;
        $sos->longitude = $request->longitude;
        $sos->note = $request->note;
        $sos->save();

        event(new SOSAlert($sos));

        return response()->json(['message' => 'SOS sent successfully.']);
    }
}
