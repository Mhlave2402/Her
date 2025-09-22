@extends('adminmodule::layouts.master')

@section('title', 'Edit Gift Card')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Edit Gift Card</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <form action="{{ route('admin.giftcard.update', $giftcard->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        <div class="form-group">
                            <label for="code">Code</label>
                            <input type="text" name="code" class="form-control" value="{{ $giftcard->code }}" required>
                        </div>
                        <div class="form-group">
                            <label for="amount">Amount</label>
                            <input type="number" name="amount" class="form-control" value="{{ $giftcard->amount }}" required>
                        </div>
                        <div class="form-group">
                            <label for="expires_at">Expires At</label>
                            <input type="date" name="expires_at" class="form-control" value="{{ $giftcard->expires_at }}" required>
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
