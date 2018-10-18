@extends('layout')

@section('content')

	@if( Auth::user()->rolid == 1 )
		<user-form title = "Modificar Usuario" url='{{ route("home") }}' :user='{{ $user }}' :cur-user='{{ Auth::user() }}' view_mode='edit'/>
	@endif

@endsection