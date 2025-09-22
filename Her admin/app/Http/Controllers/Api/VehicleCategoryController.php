<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\VehicleCategory;
use Illuminate\Http\Request;

class VehicleCategoryController extends Controller
{
    public function index()
    {
        $categories = VehicleCategory::all();
        return response()->json($categories);
    }
}
