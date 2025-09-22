<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;

class NannyController extends Controller
{
    public function index()
    {
        $nannies = User::where('is_nanny', true)->get();
        return response()->json($nannies);
    }

    public function verify(Request $request, $id)
    {
        $request->validate([
            'is_verified' => 'required|boolean',
        ]);

        $nanny = User::findOrFail($id);
        $nanny->is_kids_only_verified = $request->is_verified;
        $nanny->save();

        return response()->json(['message' => 'Nanny verification status updated successfully.']);
    }

    public function setFee(Request $request, $id)
    {
        $request->validate([
            'fee' => 'required|numeric|min:0',
        ]);

        $nanny = User::findOrFail($id);
        $nanny->nanny_service_fee = $request->fee;
        $nanny->save();

        return response()->json(['message' => 'Nanny service fee updated successfully.']);
    }
}
