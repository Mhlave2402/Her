<?php

namespace Modules\PaymentDashboard\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\TransactionManagement\Entities\Transaction;

class TransactionController extends Controller
{
    public function index(Request $request)
    {
        $transactions = Transaction::latest()->paginate(20);
        return view('paymentdashboard::transactions.index', compact('transactions'));
    }
}
