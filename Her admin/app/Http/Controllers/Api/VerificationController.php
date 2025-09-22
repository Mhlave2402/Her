<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class VerificationController extends Controller
{
    public function uploadId(Request $request)
    {
        $request->validate([
            'id_document' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
        ]);

        $user = Auth::user();
        $imageName = time().'.'.$request->id_document->extension();
        $request->id_document->storeAs('public/id_documents', $imageName);

        $user->id_document = $imageName;
        $user->save();

        return response()->json(['message' => 'ID document uploaded successfully.']);
    }
}
