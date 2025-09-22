@extends('adminmodule::layouts.master')

@section('title',translate('edit_vehicle_category'))

@section('content')
    <div class="main-content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="page-title-wrap mb-3">
                        <h2 class="page-title">{{translate('edit_vehicle_category')}}</h2>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <form action="{{route('admin.vehicle.category.update', $category->id)}}" method="POST">
                                @csrf
                                @method('PUT')
                                <div class="form-group">
                                    <label for="name">{{translate('name')}}</label>
                                    <input type="text" class="form-control" name="name" id="name" value="{{$category->name}}" required>
                                </div>
                                <div class="form-group">
                                    <label for="rank">{{translate('rank')}}</label>
                                    <input type="number" class="form-control" name="rank" id="rank" value="{{$category->rank}}" required>
                                </div>
                                <button type="submit" class="btn btn-primary">{{translate('submit')}}</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
