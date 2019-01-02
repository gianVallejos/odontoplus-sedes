@extends('layout')

@section('content')
<sede-form title = "Nueva Sede" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' view_mode='new' />
@endsection
