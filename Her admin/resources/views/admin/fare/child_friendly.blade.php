@extends('adminmodule::layouts.master')

@section('title',translate('child_friendly_fare_setup'))

@push('css_or_js')

@endpush

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3">
                        <h2 class="page-title">{{translate('child_friendly_fare_setup')}}</h2>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <form action="{{ route('admin.fare.child-friendly.store') }}" method="post">
                                @csrf
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-floating mb-30">
                                            <input type="number" class="form-control" name="fee"
                                                   placeholder="{{translate('fee')}}"
                                                   value="{{ $fee }}" required step="0.01">
                                            <label>{{translate('fee')}}</label>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="d-flex justify-content-end gap-3">
                                            <button class="btn btn--primary"
                                                    type="submit">{{translate('submit')}}</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script')


@endpush
