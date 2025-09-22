@extends('adminmodule::layouts.master')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Payment Gateways</h3>
                        <a href="{{ route('gateways.create') }}" class="btn btn-primary btn-sm float-right">Add New</a>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                        <table id="gateways-table" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                                <th>Name</th>
                                <th>Status</th>
                                <th>Priority</th>
                                <th>Mode</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            @foreach($gateways as $gateway)
                                <tr>
                                    <td>{{ $gateway->name }}</td>
                                    <td>{{ $gateway->status ? 'Active' : 'Inactive' }}</td>
                                    <td>{{ $gateway->priority }}</td>
                                    <td>{{ ucfirst($gateway->mode) }}</td>
                                    <td>
                                        <a href="{{ route('gateways.edit', $gateway->id) }}" class="btn btn-primary btn-sm">Edit</a>
                                        <form action="{{ route('gateways.destroy', $gateway->id) }}" method="POST" style="display:inline;">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                        </form>
                                    </td>
                                </tr>
                            @endforeach
                            </tbody>
                        </table>
                    </div>
                    <!-- /.card-body -->
                </div>
                <!-- /.card -->
            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.container-fluid -->
@endsection
