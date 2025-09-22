<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\GiftCard;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class WalletController extends Controller
{
    public function redeemGiftCard(Request $request)
    {
        $request->validate([
            'code' => 'required|string|exists:gift_cards,code',
        ]);

        $giftCard = GiftCard::where('code', $request->code)->first();

        if ($giftCard->is_redeemed) {
            return response()->json(['message' => 'This gift card has already been redeemed.'], 422);
        }

        $user = Auth::user();
        $user->wallet_balance += $giftCard->amount;
        $user->save();

        $giftCard->is_redeemed = true;
        $giftCard->user_id = $user->id;
        $giftCard->save();

        return response()->json(['message' => 'Gift card redeemed successfully.']);
    }

    public function topUpWithCard(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1',
            'token' => 'required|string',
        ]);

        // In a real application, you would process the payment with a payment gateway like Stripe.
        // For this example, we'll just assume the payment is successful.

        $user = Auth::user();
        $user->wallet_balance += $request->amount;
        $user->save();

        return response()->json(['message' => 'Top-up successful.']);
    }
}
