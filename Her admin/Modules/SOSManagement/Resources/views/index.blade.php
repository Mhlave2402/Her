@extends('adminmodule::layouts.master')

@section('title', 'SOS Alerts')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">SOS Alerts</h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <table id="example2" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>User</th>
                                <th>Trip ID</th>
                                <th>Coordinates</th>
                                <th>Note</th>
                                <th>Timestamp</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($soses as $sos)
                            <tr>
                                <td>{{ $sos->id }}</td>
                                <td>{{ $sos->user->name }}</td>
                                <td>{{ $sos->trip_id }}</td>
                                <td>{{ $sos->latitude }}, {{ $sos->longitude }}</td>
                                <td>{{ $sos->note }}</td>
                                <td>{{ $sos->created_at }}</td>
                                <td>
                                    <a href="https://www.google.com/maps/search/?api=1&query={{ $sos->latitude }},{{ $sos->longitude }}" target="_blank" class="btn btn-primary">View on Map</a>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix">
                    {{ $soses->links() }}
                </div>
            </div>
            <!-- /.card -->
        </div>
    </div>
</div>
@endsection
