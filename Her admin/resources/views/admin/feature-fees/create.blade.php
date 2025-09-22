@extends('admin.layouts.app')

@section('content')
<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Add New Feature Fee</h1>

    <div class="card shadow mb-4">
        <div class="card-body">
            <form action="{{ route('admin.feature-fees.store') }}" method="POST">
                @csrf
                <div class="form-group">
                    <label for="feature_key">Feature</label>
                    <select name="feature_key" id="feature_key" class="form-control">
                        <option value="child_friendly">Child-Friendly Mode</option>
                        <option value="nanny_ride">Nanny Ride</option>
                        <option value="kids_only">Kids-Only Verified Rides</option>
                        <option value="baby_seat">Baby Seat Option</option>
                        <option value="male_companion">Travel with Male Companion</option>
                        <option value="additional_premium">Additional Premium Feature</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="pricing_model">Pricing Model</label>
                    <select name="pricing_model" id="pricing_model" class="form-control">
                        <option value="flat">Flat</option>
                        <option value="percentage">Percentage</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="value">Value</label>
                    <input type="number" name="value" id="value" class="form-control" step="0.01" required>
                </div>
                <div class="form-group">
                    <label for="is_active">Status</label>
                    <select name="is_active" id="is_active" class="form-control">
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Save</button>
            </form>
        </div>
    </div>
</div>
@endsection
