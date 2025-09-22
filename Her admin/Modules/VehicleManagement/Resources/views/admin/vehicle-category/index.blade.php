@extends('adminmodule::layouts.master')

@section('title',translate('vehicle_categories'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3">
                        <h2 class="page-title">{{translate('vehicle_categories')}}</h2>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <a href="{{route('admin.vehicle.category.create')}}" class="btn btn-primary mb-3">{{translate('add_category')}}</a>
                                </div>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead>
                                        <tr>
                                            <th>{{translate('name')}}</th>
                                            <th>{{translate('rank')}}</th>
                                            <th>{{translate('action')}}</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @foreach($categories as $category)
                                            <tr>
                                                <td>{{$category->name}}</td>
                                                <td>{{$category->rank}}</td>
                                                <td>
                                                    <a href="{{route('admin.vehicle.category.edit', $category->id)}}" class="btn btn-primary btn-sm">{{translate('edit')}}</a>
                                                    <form action="{{route('admin.vehicle.category.destroy', $category->id)}}" method="POST" style="display:inline;">
                                                        @csrf
                                                        @method('DELETE')
                                                        <button type="submit" class="btn btn-danger btn-sm">{{translate('delete')}}</button>
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
            </div>
        </div>
    </div>
@endsection
