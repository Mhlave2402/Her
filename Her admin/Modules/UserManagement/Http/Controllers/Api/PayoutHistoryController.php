<?php

namespace Modules\UserManagement\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\TransactionManagement\Entities\Transaction;

class PayoutHistoryController extends Controller
{
    public function index(Request $request)
    {
        $user = auth('api')->user();

        $payouts = Transaction::where('user_id', $user->id)
            ->where('attribute', 'payout')
            ->latest()
            ->paginate(10);

        return response()->json($payouts, 200);
    }
}
