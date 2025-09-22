<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\DriverReport;

class DriverReportController extends Controller
{
    public function store(Request $request)
    {
        $request->validate([
            'driver_id' => 'required|exists:users,id',
            'reason' => 'required|string',
        ]);

        DriverReport::create([
            'driver_id' => $request->driver_id,
            'user_id' => $request->user()->id,
            'reason' => $request->reason,
        ]);

        return response()->json(['message' => 'Report submitted successfully']);
    }
}
