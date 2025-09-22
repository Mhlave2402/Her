@extends('adminmodule::layouts.master')

@section('title', 'Gift Cards')

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Gift Cards</h3>
                    <div class="card-tools">
                        <a href="{{ route('admin.giftcard.create') }}" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Add New
                        </a>
                    </div>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <table id="example2" class="table table-bordered table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Code</th>
                                <th>Amount</th>
                                <th>Redeemed By</th>
                                <th>Expires At</th>
                                <th>Created At</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($giftcards as $giftcard)
                            <tr>
                                <td>{{ $giftcard->id }}</td>
                                <td>{{ $giftcard->code }}</td>
                                <td>{{ $giftcard->amount }}</td>
                                <td>{{ $giftcard->user->name ?? 'Not Redeemed' }}</td>
                                <td>{{ $giftcard->expires_at }}</td>
                                <td>{{ $giftcard->created_at }}</td>
                                <td>
                                    <a href="{{ route('admin.giftcard.edit', $giftcard->id) }}" class="btn btn-info">Edit</a>
                                    <form action="{{ route('admin.giftcard.destroy', $giftcard->id) }}" method="POST" style="display:inline-block;">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger">Delete</button>
                                    </form>
                                </td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>
                <!-- /.card-body -->
                <div class="card-footer clearfix">
                    {{ $giftcards->links() }}
                </div>
            </div>
            <!-- /.card -->
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Bulk Generate Gift Cards</h3>
                </div>
                <div class="card-body">
                    <form action="{{ route('admin.giftcard.bulkGenerate') }}" method="POST">
                        @csrf
                        <div class="form-group">
                            <label for="number_of_cards">Number of Cards</label>
                            <input type="number" name="number_of_cards" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="amount">Amount</label>
                            <input type="number" name="amount" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="expires_at">Expires At</label>
                            <input type="date" name="expires_at" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Generate</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
