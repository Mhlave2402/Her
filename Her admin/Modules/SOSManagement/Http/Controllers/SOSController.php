<?php

namespace Modules\SOSManagement\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\SOSManagement\Entities\SOS;
use Brian2694\Toastr\Facades\Toastr;

class SOSController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $soses = SOS::latest()->paginate(20);
        return view('sosmanagement::index', compact('soses'));
    }

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

        return response()->json(['message' => 'SOS sent successfully.']);
    }
}
