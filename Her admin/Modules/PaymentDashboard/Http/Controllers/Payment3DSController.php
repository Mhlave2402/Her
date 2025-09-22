<?php

namespace Modules\PaymentDashboard\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Modules\PaymentDashboard\Services\PaymentService;

class Payment3DSController extends Controller
{
    protected $paymentService;

    public function __construct(PaymentService $paymentService)
    {
        $this->paymentService = $paymentService;
    }

    /**
     * Handle the 3DS callback from the payment gateway.
     *
     * @param Request $request
     * @param string $gateway
     * @return JsonResponse
     */
    public function handleCallback(Request $request, string $gateway): JsonResponse
    {
        $result = $this->paymentService
            ->setGateway($gateway)
            ->verify3DS($request->all());

        if ($result['success']) {
            // You might want to redirect to a success page or return a JSON response
            return response()->json(['status' => 'success', 'data' => $result['data']]);
        }

        // Redirect to a failure page or return an error response
        return response()->json(['status' => 'failed', 'message' => $result['message']], 422);
    }
}
