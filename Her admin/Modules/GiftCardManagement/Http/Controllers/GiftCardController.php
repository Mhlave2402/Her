<?php

namespace Modules\GiftCardManagement\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Routing\Controller;
use Modules\GiftCardManagement\Entities\GiftCard;
use Modules\GiftCardManagement\Entities\GiftCardTransaction;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Support\Str;

class GiftCardController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Response
     */
    public function index()
    {
        $giftcards = GiftCard::latest()->paginate(20);
        return view('giftcardmanagement::index', compact('giftcards'));
    }

    public function list()
    {
        $giftcards = GiftCard::latest()->paginate(20);
        return response()->json($giftcards);
    }

    /**
     * Show the form for creating a new resource.
     * @return Response
     */
    public function create()
    {
        return view('giftcardmanagement::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'code' => 'required|unique:gift_cards',
            'amount' => 'required|numeric',
            'expires_at' => 'required|date',
        ]);

        GiftCard::create($request->all());

        Toastr::success('Gift card created successfully.');
        return redirect()->route('admin.giftcard.index');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Response
     */
    public function edit($id)
    {
        $giftcard = GiftCard::find($id);
        return view('giftcardmanagement::edit', compact('giftcard'));
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'code' => 'required|unique:gift_cards,code,' . $id,
            'amount' => 'required|numeric',
            'expires_at' => 'required|date',
        ]);

        $giftcard = GiftCard::find($id);
        $giftcard->update($request->all());

        Toastr::success('Gift card updated successfully.');
        return redirect()->route('admin.giftcard.index');
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Response
     */
    public function destroy($id)
    {
        GiftCard::destroy($id);
        Toastr::success('Gift card deleted successfully.');
        return back();
    }

    public function bulkGenerate(Request $request)
    {
        $request->validate([
            'number_of_cards' => 'required|integer|min:1',
            'amount' => 'required|numeric',
            'expires_at' => 'required|date',
        ]);

        for ($i = 0; $i < $request->number_of_cards; $i++) {
            GiftCard::create([
                'code' => Str::random(16),
                'amount' => $request->amount,
                'expires_at' => $request->expires_at,
            ]);
        }

        Toastr::success('Gift cards generated successfully.');
        return back();
    }

    public function redeem(Request $request)
    {
        $request->validate([
            'code' => 'required',
        ]);

        $giftcard = GiftCard::where('code', $request->code)
            ->where('expires_at', '>', now())
            ->whereNull('user_id')
            ->first();

        if (!$giftcard) {
            return response()->json(['message' => 'Invalid or expired gift card.'], 404);
        }

        $user = $request->user();
        $giftcard->user_id = $user->id;
        $giftcard->save();

        $user->userAccount()->increment('wallet_balance', $giftcard->amount);

        GiftCardTransaction::create([
            'gift_card_id' => $giftcard->id,
            'user_id' => $user->id,
            'trip_request_id' => $request->trip_request_id,
            'amount' => $giftcard->amount,
        ]);

        return response()->json(['message' => 'Gift card redeemed successfully.']);
    }

    public function balance(Request $request)
    {
        $user = $request->user();
        return response()->json(['balance' => $user->userAccount->wallet_balance]);
    }

    public function getTripPayment(Request $request, $trip_id)
    {
        $transaction = GiftCardTransaction::where('trip_request_id', $trip_id)->first();

        if ($transaction) {
            return response()->json(['paid_by_gift_card' => true, 'amount' => $transaction->amount]);
        }

        return response()->json(['paid_by_gift_card' => false]);
    }
}
