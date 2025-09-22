<?php

namespace Modules\TripManagement\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Modules\TripManagement\Entities\TripRequest;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Validator;
use Modules\TripManagement\Service\Interface\TripRequestServiceInterface;

class ShortfallController extends Controller
{
    protected $tripRequestService;

    public function __construct(TripRequestServiceInterface $tripRequestService)
    {
        $this->tripRequestService = $tripRequestService;
    }

    public function getShortfallList(Request $request): JsonResponse
    {
        $trips = TripRequest::where('is_shortfall_active', true)->get();
        return response()->json(['data' => $trips], 200);
    }

    public function getShortfallDetails($trip_request_id): JsonResponse
    {
        $trip = TripRequest::find($trip_request_id);

        if (!$trip || !$trip->is_shortfall_active) {
            return response()->json(['message' => 'Shortfall not found'], 404);
        }

        return response()->json(['data' => $trip], 200);
    }

    public function updateShortfall(Request $request, $trip_request_id): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'shortfall_installments_remaining' => 'integer|min:0',
            'shortfall_per_trip' => 'numeric|min:0',
            'shortfall_percentage' => 'numeric|min:0|max:100',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $trip = $this->tripRequestService->findOne(id: $trip_request_id);

        if (!$trip || !$trip->is_shortfall_active) {
            return response()->json(['message' => 'Shortfall not found'], 404);
        }

        $updatedTrip = $this->tripRequestService->updateTrip($request->only(['shortfall_installments_remaining', 'shortfall_per_trip', 'shortfall_percentage']), $trip_request_id);

        return response()->json(['message' => 'Shortfall updated successfully', 'data' => $updatedTrip], 200);
    }

    public function cancelShortfall($trip_request_id): JsonResponse
    {
        $trip = $this->tripRequestService->findOne(id: $trip_request_id);

        if (!$trip || !$trip->is_shortfall_active) {
            return response()->json(['message' => 'Shortfall not found'], 404);
        }

        $this->tripRequestService->updateTrip([
            'is_shortfall_active' => false,
            'shortfall_recovery_completed' => true,
        ], $trip_request_id);

        return response()->json(['message' => 'Shortfall cancelled successfully'], 200);
    }

    public function recordShortfall(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'trip_request_id' => 'required|uuid',
            'amount_paid_in_cash' => 'required|numeric|min:0',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $trip = $this->tripRequestService->findOne(id: $request->trip_request_id);

        if (!$trip) {
            return response()->json(['message' => 'Trip not found'], 404);
        }

        if ($trip->payment_method !== 'cash') {
            return response()->json(['message' => 'Shortfall can only be recorded for cash trips'], 400);
        }

        $attributes = [
            'trip_request_id' => $request->trip_request_id,
            'amount_paid_in_cash' => $request->amount_paid_in_cash,
        ];

        $result = $this->tripRequestService->processCashPayment($attributes);

        switch ($result['status']) {
            case 'overpaid':
                return response()->json(['message' => 'Overpayment of ' . $result['amount'] . ' credited to customer wallet.'], 200);
            case 'shortfall':
                return response()->json(['message' => 'Shortfall recorded successfully', 'data' => $result['data']], 200);
            case 'paid':
                return response()->json(['message' => 'Payment received successfully.'], 200);
            default:
                return response()->json(['message' => $result['message']], 400);
        }
    }

    public function adjustShortfall(Request $request, $trip_request_id): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'installments' => 'required|integer|min:1',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $trip = $this->tripRequestService->findOne(id: $trip_request_id);

        if (!$trip || !$trip->is_shortfall_active) {
            return response()->json(['message' => 'Shortfall not found'], 404);
        }

        $installments = $request->input('installments');
        $shortfallAmount = $trip->shortfall_amount;

        $updatedTrip = $this->tripRequestService->updateTrip([
            'shortfall_installments_remaining' => $installments,
            'shortfall_per_trip' => round($shortfallAmount / $installments, 2),
        ], $trip_request_id);

        return response()->json(['message' => 'Shortfall adjusted successfully', 'data' => $updatedTrip], 200);
    }

    public function payShortfall(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'trip_id' => 'required|uuid',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 400);
        }

        $trip = $this->tripRequestService->findOne(id: $request->trip_id);

        if (!$trip || !$trip->has_shortfall) {
            return response()->json(['message' => 'Shortfall not found for this trip'], 404);
        }

        $customer = $trip->customer;
        $shortfallAmount = $trip->shortfall_amount;

        if ($customer->wallet_balance < $shortfallAmount) {
            return response()->json(['message' => 'Insufficient wallet balance'], 400);
        }

        $customer->wallet_balance -= $shortfallAmount;
        $customer->save();

        $this->tripRequestService->update(
            [
                'has_shortfall' => false,
                'shortfall_status' => 'paid',
            ],
            $trip->id
        );

        return response()->json(['message' => 'Shortfall paid successfully'], 200);
    }
}
