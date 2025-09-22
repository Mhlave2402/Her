<?php

namespace Modules\PaymentDashboard\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Modules\PaymentDashboard\Entities\PaymentGateway;

class GatewayController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $gateways = PaymentGateway::all();
        return view('paymentdashboard::gateways.index', compact('gateways'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('paymentdashboard::gateways.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request): RedirectResponse
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'test_key' => 'required|string|max:255',
            'live_key' => 'required|string|max:255',
            'status' => 'required|boolean',
        ]);

        PaymentGateway::create($request->all());

        return redirect()->route('gateways.index')
            ->with('success', 'Gateway created successfully.');
    }

    /**
     * Show the specified resource.
     */
    public function show($id)
    {
        return view('paymentdashboard::show');
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        $gateway = PaymentGateway::findOrFail($id);
        return view('paymentdashboard::gateways.edit', compact('gateway'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id): RedirectResponse
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'test_key' => 'required|string|max:255',
            'live_key' => 'required|string|max:255',
            'status' => 'required|boolean',
        ]);

        $gateway = PaymentGateway::findOrFail($id);
        $gateway->update($request->all());

        return redirect()->route('gateways.index')
            ->with('success', 'Gateway updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id): RedirectResponse
    {
        $gateway = PaymentGateway::findOrFail($id);
        $gateway->delete();

        return redirect()->route('gateways.index')
            ->with('success', 'Gateway deleted successfully.');
    }
}
