@extends('paymentdashboard::layouts.master')

@section('content')
    <div class="container">
        <h2>Create Gateway</h2>
        <form action="{{ route('gateways.store') }}" method="POST">
            @csrf
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="test_key">Test Key</label>
                <input type="text" name="test_key" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="live_key">Live Key</label>
                <input type="text" name="live_key" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="status">Status</label>
                <select name="status" class="form-control">
                    <option value="1">Active</option>
                    <option value="0">Inactive</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Create</button>
        </form>
    </div>
@endsection
