<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class ChildFriendlyFeeController extends Controller
{
    public function index()
    {
        $fee = config('child_friendly.fee');
        return view('admin.fare.child_friendly', compact('fee'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'fee' => 'required|numeric|min:0',
        ]);

        $path = base_path('config/child_friendly.php');
        $config = File::get($path);
        $config = str_replace(config('child_friendly.fee'), $request->fee, $config);
        File::put($path, $config);

        return back()->with('success', 'Fee updated successfully');
    }
}
