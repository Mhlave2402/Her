@extends('paymentdashboard::layouts.master')

@section('content')
    <div class="container">
        <h2>Edit Gateway</h2>
        <form action="{{ route('gateways.update', $gateway->id) }}" method="POST">
            @csrf
            @method('PUT')
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" name="name" class="form-control" value="{{ $gateway->name }}" required>
            </div>
            <div class="form-group">
                <label for="test_key">Test Key</label>
                <input type="text" name="test_key" class="form-control" value="{{ $gateway->test_key }}" required>
            </div>
            <div class="form-group">
                <label for="live_key">Live Key</label>
                <input type="text" name="live_key" class="form-control" value="{{ $gateway->live_key }}" required>
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status" class="form-control">
                    <option value="1" {{ $gateway->status ? 'selected' : '' }}>Active</option>
                    <option value="0" {{ !$gateway->status ? 'selected' : '' }}>Inactive</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Update</button>
        </form>
    </div>
@endsection
