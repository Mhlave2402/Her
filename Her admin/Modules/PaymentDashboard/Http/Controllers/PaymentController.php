<?php

namespace Modules\PaymentDashboard\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Http\Controllers\Controller;
use Modules\PaymentDashboard\Services\PaymentService;

class PaymentController extends Controller
{
    protected $paymentService;

    public function __construct(PaymentService $paymentService)
    {
        $this->paymentService = $paymentService;
    }

    /**
     * Handle a payment request.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function pay(Request $request): JsonResponse
    {
        $request->validate([
            'amount' => 'required|numeric|min:0.50',
            'token' => 'required|string',
            'gateway' => 'required|string', // e.g., 'stripe', 'paystack'
        ]);

        $result = $this->paymentService
            ->setGateway($request->gateway)
            ->processPayment($request->amount, $request->token);

        if ($result['success']) {
            return response()->json($result['data']);
        }

        return response()->json(['error' => $result['message']], 422);
    }

    /**
     * Handle a request to save a card.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function saveCard(Request $request): JsonResponse
    {
        $request->validate([
            'token' => 'required|string',
            'gateway' => 'required|string',
        ]);

        $result = $this->paymentService
            ->setGateway($request->gateway)
            ->addCard($request->token);

        if ($result['success']) {
            return response()->json($result['data']);
        }

        return response()->json(['error' => $result['message']], 422);
    }
}
