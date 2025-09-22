@extends('admin.layouts.app')

@section('content')
<div class="container-fluid">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h1 class="h3 mb-0 text-gray-800">Feature Fees</h1>
        <a href="{{ route('admin.feature-fees.create') }}" class="btn btn-primary">Add New</a>
    </div>

    <div class="card shadow mb-4">
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>Feature</th>
                            <th>Zone</th>
                            <th>Vehicle Type</th>
                            <th>Pricing Model</th>
                            <th>Value</th>
                            <th>Active</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($configs as $config)
                        <tr>
                            <td>{{ $config->feature_key }}</td>
                            <td>{{ $config->zone->name ?? 'All Zones' }}</td>
                            <td>{{ $config->vehicle_type ?? 'All' }}</td>
                            <td>{{ $config->pricing_model }}</td>
                            <td>{{ $config->value }}</td>
                            <td>{{ $config->is_active ? 'Yes' : 'No' }}</td>
                            <td>
                                <a href="{{ route('admin.feature-fees.edit', $config->id) }}" class="btn btn-sm btn-primary">Edit</a>
                                <form action="{{ route('admin.feature-fees.destroy', $config->id) }}" method="POST" style="display:inline-block;">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                                </form>
                            </td>
                        </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
