@extends('admin.layouts.app')

@section('content')
    <div id="app">
        <nanny-management></nanny-management>
    </div>
@endsection

@push('scripts')
    <script src="{{ mix('js/app.js') }}"></script>
@endpush
