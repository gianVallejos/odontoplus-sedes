@extends('layout')

@section('content')
<doctor-form title = "Nuevo Doctor" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' view_mode='new' />
@endsection