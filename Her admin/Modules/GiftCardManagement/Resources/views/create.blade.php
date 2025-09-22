@extends('adminmodule::layouts.master')

@section('title', 'Create Gift Card')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Create Gift Card</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <form action="{{ route('admin.giftcard.store') }}" method="POST">
                        @csrf
                        <div class="form-group">
                            <label for="code">Code</label>
                            <input type="text" name="code" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="amount">Amount</label>
                            <input type="number" name="amount" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="expires_at">Expires At</label>
                            <input type="date" name="expires_at" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit</button>
                    </form>
                </div>
                <!-- /.card-body -->
            </div>
            <!-- /.card -->
        </div>
    </div>
</div>
@endsection
