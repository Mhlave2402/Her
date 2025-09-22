@extends('usermanagement::layouts.master')

@section('title', translate('Driver_Reports'))

@push('css_or_js')
@endpush

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="page-header">
                <div class="d-flex flex-wrap justify-content-between align-items-center">
                    <h2 class="page-header-title">{{translate('Driver_Reports')}}</h2>
                </div>
            </div>

            <div class="card">
                <div class="card-header">
                    <h5 class="card-title">{{translate('driver_reports_list')}}</h5>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>{{translate('SL')}}</th>
                                    <th>{{translate('Driver')}}</th>
                                    <th>{{translate('User')}}</th>
                                    <th>{{translate('Reason')}}</th>
                                    <th>{{translate('Reported_At')}}</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse($reports as $key => $report)
                                    <tr>
                                        <td>{{$reports->firstItem() + $key}}</td>
                                        <td>{{$report->driver?->first_name}} {{$report->driver?->last_name}}</td>
                                        <td>{{$report->user?->first_name}} {{$report->user?->last_name}}</td>
                                        <td>{{$report->reason}}</td>
                                        <td>{{date('Y-m-d H:i', strtotime($report->created_at))}}</td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="5" class="text-center">{{translate('No_reports_found')}}</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>

                    <div class="d-flex justify-content-end">
                        {{$reports->links()}}
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
