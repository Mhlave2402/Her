<?php

namespace Modules\SplitPaymentManagement\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\SplitPaymentManagement\Entities\SplitPayment;
use Modules\TripManagement\Entities\TripRequest;
use App\Models\User;
use App\Service\PaymentService;
use Brian2694\Toastr\Facades\Toastr;

class SplitPaymentController extends Controller
{
    private $paymentService;

    public function __construct(PaymentService $paymentService)
    {
        $this->paymentService = $paymentService;
    }
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $split_payments = SplitPayment::latest()->paginate(20);
        return view('splitpaymentmanagement::index', compact('split_payments'));
    }

    public function requestSplit(Request $request)
    {
        $request->validate([
            'trip_id' => 'required',
            'user_id' => 'required|exists:users,id',
        ]);

        $trip = TripRequest::find($request->trip_id);
        $user = User::find($request->user_id);

        if (!$trip || !$user) {
            return response()->json(['message' => 'Invalid trip or user.'], 404);
        }

        $split_payment = SplitPayment::create([
            'trip_id' => $trip->id,
            'user_id' => $request->user()->id,
            'with_user_id' => $user->id,
            'status' => 'pending',
        ]);

        // You would typically send a notification to the other user here.
        // This is a placeholder for that logic.

        return response()->json(['message' => 'Split payment request sent.']);
    }

    public function acceptSplit(Request $request)
    {
        $request->validate([
            'split_payment_id' => 'required|exists:split_payments,id',
        ]);

        $split_payment = SplitPayment::find($request->split_payment_id);

        if ($split_payment->with_user_id !== $request->user()->id) {
            return response()->json(['message' => 'Unauthorized.'], 403);
        }

        $split_payment->status = 'accepted';
        $split_payment->save();

        $trip = TripRequest::find($split_payment->trip_id);
        $trip->payment_method = 'split_payment';
        $trip->split_with = $split_payment->with_user_id;
        $trip->save();
        $fare = $trip->fare;
        $split_fare = $fare / 2;

        $user1 = User::find($split_payment->user_id);
        $user2 = User::find($split_payment->with_user_id);

        $payment1_processed = $this->paymentService->processPayment($user1, $split_fare);
        $payment2_processed = $this->paymentService->processPayment($user2, $split_fare);

        if ($payment1_processed && $payment2_processed) {
            return response()->json(['message' => 'Split payment accepted.']);
        }

        // Revert the first payment if the second one fails
        if ($payment1_processed) {
            $user1->wallet_balance += $split_fare;
            $user1->save();
        }

        return response()->json(['message' => 'Payment failed. Please try again.'], 400);
    }
}
