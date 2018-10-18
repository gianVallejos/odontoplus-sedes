@extends('layout')

@section('content')
	<tratamiento-form title = "Nuevo Tratamiento" url='{{ route("home") }}':cur-user='{{ Auth::user() }}' view_mode='new' />
@endsection