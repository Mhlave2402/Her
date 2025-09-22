@extends('layouts.admin.app')

@section('content')
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">Baby Seat Fee</h3>
                    </div>
                    <div class="card-body">
                        <form action="{{ route('admin.baby-seat-fee.store') }}" method="POST">
                            @csrf
                            <div class="form-group">
                                <label for="fee">Fee</label>
                                <input type="number" name="fee" id="fee" class="form-control" value="{{ $fee->fee ?? 0 }}" min="0" step="0.01">
                            </div>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
