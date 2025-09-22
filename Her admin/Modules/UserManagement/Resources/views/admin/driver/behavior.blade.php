@extends('adminmodule::layouts.master')

@section('title', translate('Driver Behavior'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3">
                        <h2 class="page-title">{{ translate('Driver Behavior') }}</h2>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="row gy-3">
                                <div class="col-lg-12">
                                    <div class="d-flex flex-wrap justify-content-end gap-3">
                                        <div class="dropdown">
                                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="dropdown">
                                                <i class="bi bi-download"></i>
                                                {{ translate('download') }}
                                                <i class="bi bi-caret-down-fill"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right">
                                                <li><a class="dropdown-item" href="#">{{ translate('excel') }}</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="table-responsive">
                                        <table class="table table-borderless table-striped">
                                            <thead>
                                            <tr>
                                                <th>{{ translate('SL') }}</th>
                                                <th>{{ translate('Driver') }}</th>
                                                <th>{{ translate('Behavior Type') }}</th>
                                                <th>{{ translate('Value') }}</th>
                                                <th>{{ translate('Date') }}</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            @foreach ($behaviors as $key => $behavior)
                                                <tr>
                                                    <td>{{ $key + 1 }}</td>
                                                    <td>{{ $behavior->driver->first_name }} {{ $behavior->driver->last_name }}</td>
                                                    <td>{{ translate($behavior->type) }}</td>
                                                    <td>{{ $behavior->value }}</td>
                                                    <td>{{ $behavior->created_at->format('Y-m-d H:i:s') }}</td>
                                                </tr>
                                            @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="d-flex justify-content-end">
                                        {!! $behaviors->links() !!}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
