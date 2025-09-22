@extends('adminmodule::layouts.master')

@section('title', 'Split Payments')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Split Payments</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <table id="example2" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Trip ID</th>
                                <th>Requested By</th>
                                <th>With User</th>
                                <th>Status</th>
                                <th>Created At</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($split_payments as $split_payment)
                            <tr>
                                <td>{{ $split_payment->id }}</td>
                                <td>{{ $split_payment->trip_id }}</td>
                                <td>{{ $split_payment->user->name }}</td>
                                <td>{{ $split_payment->withUser->name }}</td>
                                <td>{{ $split_payment->status }}</td>
                                <td>{{ $split_payment->created_at }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix">
                    {{ $split_payments->links() }}
                </div>
            </div>
            <!-- /.card -->
        </div>
    </div>
</div>
@endsection
