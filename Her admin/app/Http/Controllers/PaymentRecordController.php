<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
    use App\Services\PaymentService;
    use Modules\TripManagement\Interfaces\TripRequestInterfaces;

class PaymentRecordController extends Controller
{
    private $paymentService;
    private $trip;

    public function __construct(
        PaymentService $paymentService,
        TripRequestInterfaces $trip
    ) {
        $this->paymentService = $paymentService;
        $this->trip = $trip;
    }

    public function index(Request $request)
    {

        $allowedPaymentMethods = [
            'ssl_commerz', 'wallet', 'cash', 'stripe', 'paypal', 'razor_pay', 'paystack',
            'senang_pay', 'paymob_accept', 'flutterwave', 'paytm', 'paytabs', 'liqpay',
            'mercadopago', 'bkash', 'fatoorah', 'xendit', 'amazon_pay', 'iyzi_pay',
            'hyper_pay', 'foloosi', 'ccavenue', 'pvit', 'moncash', 'thawani', 'tap',
            'viva_wallet', 'hubtel', 'maxicash', 'esewa', 'swish', 'momo', 'payfast',
            'worldpay', 'sixcash'
        ];

        $validator = Validator::make($request->all(), [
            'trip_request_id' => 'required',
            'payment_method' => 'required|in:' . implode(',', $allowedPaymentMethods)
        ]);
        if ($validator->fails()) {

            return response()->json(errorProcessor($validator), 400);
        }

        $trip = $this->trip->getBy(column: 'id', value: $request->trip_request_id, attributes: [
            'relations' => ['customer', 'driver']
        ]);
        if (!$trip) {
            return response()->json(['message' => 'trip id not valid'], 403);
        }
        $customer = $trip->customer;

        // Remove old payment gateway initialization
        // We're now using the new PaymentService
        $paymentData = [
            'amount' => $trip->paid_fare,
            'currency' => businessConfig('currency_code')?->value ?? 'USD',
            'user_id' => $customer->id,
            'reference_id' => $request->trip_request_id,
            'payment_method' => $request->payment_method,
            'requires_3ds' => true,
            'card_data' => $request->only(['card_number', 'exp_month', 'exp_year', 'cvc']),
            'save_card' => $request->input('save_card', false)
        ];

        try {
            $result = $this->paymentService->processPayment($paymentData);
        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ], 500);
        }

        if ($result['status'] === 'requires_3ds') {
            return redirect($result['redirect_url']);
        }

        return $result['status'] === 'success' 
            ? $this->success() 
            : $this->fail();
    }

    public function success()
    {
        return response()->json(['message' => 'Payment succeeded'], 200);
    }

    public function fail()
    {
        return response()->json(['message' => 'Payment failed'], 403);
    }

    public function cancel()
    {
        return response()->json(['message' => 'Payment canceled'], 405);
    }

}
