<?php

namespace App\Service;

use App\Models\User;

class PaymentService
{
    public function processPayment(User $user, float $amount)
    {
        // This is a placeholder for the actual payment processing logic.
        // In a real-world application, you would integrate with a payment gateway here.
        if ($user->wallet_balance >= $amount) {
            $user->wallet_balance -= $amount;
            $user->save();
            return true;
        }

        return false;
    }
}
