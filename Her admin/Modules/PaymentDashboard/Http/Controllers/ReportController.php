<?php

namespace Modules\PaymentDashboard\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\TransactionManagement\Entities\Transaction;

class ReportController extends Controller
{
    public function index(Request $request)
    {
        $totalRevenue = Transaction::where('status', 'completed')->sum('amount');
        $totalTransactions = Transaction::count();
        $successfulTransactions = Transaction::where('status', 'completed')->count();
        $failedTransactions = Transaction::where('status', 'failed')->count();

        return view('paymentdashboard::reports.index', compact(
            'totalRevenue',
            'totalTransactions',
            'successfulTransactions',
            'failedTransactions'
        ));
    }
}
