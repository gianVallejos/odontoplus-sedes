@extends('layout')

@section('content')
	<egreso-form title = "Nuevo Egreso" url='{{ route("home") }}' view_mode='new' :cur-user='{{ Auth::user() }}' :doctores="{{ $doctores }}" />
@endsection