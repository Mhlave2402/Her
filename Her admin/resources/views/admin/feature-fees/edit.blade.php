@extends('admin.layouts.app')

@section('content')
<div class="container-fluid">
    <h1 class="h3 mb-4 text-gray-800">Edit Feature Fee</h1>

    <div class="card shadow mb-4">
        <div class="card-body">
            <form action="{{ route('admin.feature-fees.update', $featureFee->id) }}" method="POST">
                @csrf
                @method('PUT')
                <div class="form-group">
                    <label for="feature_key">Feature</label>
                    <select name="feature_key" id="feature_key" class="form-control">
                        <option value="child_friendly" @if($featureFee->feature_key == 'child_friendly') selected @endif>Child-Friendly Mode</option>
                        <option value="nanny_ride" @if($featureFee->feature_key == 'nanny_ride') selected @endif>Nanny Ride</option>
                        <option value="kids_only" @if($featureFee->feature_key == 'kids_only') selected @endif>Kids-Only Verified Rides</option>
                        <option value="baby_seat" @if($featureFee->feature_key == 'baby_seat') selected @endif>Baby Seat Option</option>
                        <option value="male_companion" @if($featureFee->feature_key == 'male_companion') selected @endif>Travel with Male Companion</option>
                        <option value="additional_premium" @if($featureFee->feature_key == 'additional_premium') selected @endif>Additional Premium Feature</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="pricing_model">Pricing Model</label>
                    <select name="pricing_model" id="pricing_model" class="form-control">
                        <option value="flat" @if($featureFee->pricing_model == 'flat') selected @endif>Flat</option>
                        <option value="percentage" @if($featureFee->pricing_model == 'percentage') selected @endif>Percentage</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="value">Value</label>
                    <input type="number" name="value" id="value" class="form-control" step="0.01" value="{{ $featureFee->value }}" required>
                </div>
                <div class="form-group">
                    <label for="is_active">Status</label>
                    <select name="is_active" id="is_active" class="form-control">
                        <option value="1" @if($featureFee->is_active) selected @endif>Active</option>
                        <option value="0" @if(!$featureFee->is_active) selected @endif>Inactive</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Update</button>
            </form>
        </div>
    </div>
</div>
@endsection
