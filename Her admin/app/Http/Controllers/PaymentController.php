<?php

namespace App\Http\Controllers;

use App\Services\PaymentService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class PaymentController extends Controller
{
    private $paymentService;

    public function __construct(PaymentService $paymentService)
    {
        $this->paymentService = $paymentService;
    }

    public function processPayment(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'amount' => 'required|numeric|min:0.01',
            'currency' => 'required|string|size:3',
            'user_id' => 'required|integer|exists:users,id',
            'reference_id' => 'required|string',
            'save_card' => 'boolean',
            'saved_card_id' => 'nullable|integer|exists:saved_cards,id',
            'requires_3ds' => 'boolean',
            'card_data' => 'nullable|array',
            'card_data.card_number' => 'required_if:saved_card_id,null|string',
            'card_data.exp_month' => 'required_if:saved_card_id,null|string|size:2',
            'card_data.exp_year' => 'required_if:saved_card_id,null|string|size:4',
            'card_data.cvc' => 'required_if:saved_card_id,null|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Validation failed',
                'errors' => $validator->errors()
            ], 400);
        }

        $paymentData = $request->only([
            'amount', 'currency', 'user_id', 'reference_id',
            'save_card', 'saved_card_id', 'requires_3ds'
        ]);

        if ($request->has('card_data')) {
            $paymentData['card_data'] = $request->input('card_data');
        }

        $result = $this->paymentService->processPayment($paymentData);

        return response()->json($result);
    }
}
