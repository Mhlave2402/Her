@extends('paymentdashboard::layouts.master')

@section('content')
    <div class="container">
        <h2>Reports & Analytics</h2>
        <div class="row">
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Total Revenue</h5>
                        <p class="card-text">${{ number_format($totalRevenue, 2) }}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Total Transactions</h5>
                        <p class="card-text">{{ $totalTransactions }}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Successful Transactions</h5>
                        <p class="card-text">{{ $successfulTransactions }}</p>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Failed Transactions</h5>
                        <p class="card-text">{{ $failedTransactions }}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
