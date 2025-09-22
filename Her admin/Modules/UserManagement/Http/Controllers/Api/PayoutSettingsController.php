<?php

namespace Modules\UserManagement\Http\Controllers\Api;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Validator;
use Modules\UserManagement\Entities\UserAccount;

class PayoutSettingsController extends Controller
{
    public function update(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'auto_withdraw_enabled' => 'required|boolean',
            'payout_threshold' => 'nullable|numeric|min:0',
            'payout_schedule' => 'required|in:manual,daily,weekly,monthly',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 403);
        }

        $user = auth('api')->user();
        $userAccount = UserAccount::firstOrNew(['user_id' => $user->id]);

        $userAccount->auto_withdraw_enabled = $request->auto_withdraw_enabled;
        $userAccount->payout_threshold = $request->payout_threshold;
        $userAccount->payout_schedule = $request->payout_schedule;
        $userAccount->save();

        return response()->json(['message' => 'Payout settings updated successfully.'], 200);
    }
}
