<?php

namespace Modules\VehicleManagement\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\VehicleManagement\Entities\VehicleCategory;
use Brian2694\Toastr\Facades\Toastr;

class VehicleCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $categories = VehicleCategory::orderBy('rank')->get();
        return view('vehiclemanagement::admin.vehicle-category.index', compact('categories'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('vehiclemanagement::admin.vehicle-category.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|unique:vehicle_categories',
            'rank' => 'required|integer|min:1'
        ]);

        $category = new VehicleCategory();
        $category->name = $request->name;
        $category->rank = $request->rank;
        $category->save();

        Toastr::success(VEHICLE_CATEGORY_CREATE_200);

        return redirect()->route('admin.vehicle.category.index');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        $category = VehicleCategory::findOrFail($id);
        return view('vehiclemanagement::admin.vehicle-category.edit', compact('category'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        $request->validate([
            'name' => 'required|unique:vehicle_categories,name,'.$id,
            'rank' => 'required|integer|min:1'
        ]);

        $category = VehicleCategory::findOrFail($id);
        $category->name = $request->name;
        $category->rank = $request->rank;
        $category->save();

        Toastr::success(VEHICLE_CATEGORY_UPDATE_200);

        return redirect()->route('admin.vehicle.category.index');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $category = VehicleCategory::findOrFail($id);
        $category->delete();

        Toastr::success(VEHICLE_CATEGORY_DELETE_200);

        return back();
    }
}
