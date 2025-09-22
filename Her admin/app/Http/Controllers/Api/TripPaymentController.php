<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Modules\TripManagement\Entities\TripRequest;
use App\Models\TripParticipant;
use App\Models\TripPayment;

class TripPaymentController extends Controller
{
    public function inviteParticipant(Request $request, $tripId)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'share_percentage' => 'required|numeric|min:0|max:100',
            'is_primary' => 'boolean'
        ]);

        $trip = TripRequest::findOrFail($tripId);
        
        // Check if user is the trip owner
        if ($trip->customer_id !== Auth::id()) {
            return response()->json(['message' => 'Unauthorized'], 403);
        }

        $participant = TripParticipant::create([
            'trip_id' => $tripId,
            'user_id' => $request->user_id,
            'share_percentage' => $request->share_percentage,
            'is_primary' => $request->is_primary ?? false
        ]);

        return response()->json($participant, 201);
    }

    public function recordPayment(Request $request, $tripId)
    {
        $request->validate([
            'participant_id' => 'required|exists:trip_participants,id',
            'amount' => 'required|numeric|min:0',
            'payment_method' => 'required|string'
        ]);

        $trip = TripRequest::findOrFail($tripId);
        $participant = TripParticipant::findOrFail($request->participant_id);
        
        // Verify participant belongs to this trip
        if ($participant->trip_id !== $trip->id) {
            return response()->json(['message' => 'Invalid participant for this trip'], 400);
        }

        $payment = TripPayment::create([
            'participant_id' => $request->participant_id,
            'amount' => $request->amount,
            'payment_method' => $request->payment_method,
            'status' => 'completed'
        ]);

        // Update participant's paid amount
        $participant->amount_paid += $request->amount;
        $participant->save();

        return response()->json($payment, 201);
    }

    public function getPaymentStatus($tripId)
    {
        $trip = TripRequest::with(['participants', 'participants.payments'])
            ->findOrFail($tripId);

        // Calculate payment status
        $totalDue = $trip->getDiscountActualFareAttribute();
        $totalPaid = 0;
        
        foreach ($trip->participants as $participant) {
            $totalPaid += $participant->amount_paid;
        }

        return response()->json([
            'total_due' => $totalDue,
            'total_paid' => $totalPaid,
            'balance' => $totalDue - $totalPaid,
            'participants' => $trip->participants
        ]);
    }
}
