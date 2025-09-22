<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\FeatureFeeConfig;
use Illuminate\Http\Request;

class FeatureFeeConfigController extends Controller
{
    public function index()
    {
        $configs = FeatureFeeConfig::with(['zone', 'createdByUser', 'updatedByUser'])->get();
        return view('admin.feature-fees.index', compact('configs'));
    }

    public function create()
    {
        return view('admin.feature-fees.create');
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'feature_key' => 'required|string',
            'pricing_model' => 'required|in:flat,percentage',
            'value' => 'required|numeric',
            'is_active' => 'boolean',
        ]);

        FeatureFeeConfig::create($request->all());

        return redirect()->route('admin.feature-fees.index')->with('success', 'Feature fee created successfully.');
    }

    public function edit(FeatureFeeConfig $featureFee)
    {
        return view('admin.feature-fees.edit', compact('featureFee'));
    }

    public function update(Request $request, FeatureFeeConfig $featureFee)
    {
        $this->validate($request, [
            'feature_key' => 'required|string',
            'pricing_model' => 'required|in:flat,percentage',
            'value' => 'required|numeric',
            'is_active' => 'boolean',
        ]);

        $featureFee->update($request->all());

        return redirect()->route('admin.feature-fees.index')->with('success', 'Feature fee updated successfully.');
    }

    public function destroy(FeatureFeeConfig $featureFee)
    {
        $featureFee->delete();
        return redirect()->route('admin.feature-fees.index')->with('success', 'Feature fee deleted successfully.');
    }
}
