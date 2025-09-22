<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\BabySeatFee;
use Illuminate\Http\Request;

class BabySeatFeeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $fee = BabySeatFee::first();
        return view('admin.baby-seat-fee.index', compact('fee'));
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'fee' => 'required|numeric|min:0',
        ]);

        $fee = BabySeatFee::first();
        if ($fee) {
            $fee->update(['fee' => $request->fee]);
        } else {
            BabySeatFee::create(['fee' => $request->fee]);
        }

        return back()->with('success', 'Fee updated successfully');
    }
}
