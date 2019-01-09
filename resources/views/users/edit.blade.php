@extends('layout')

@section('content')

	@if( Auth::user()->rolid == 1 )
		<user-form title = "Modificar Usuario" url='{{ route("home") }}' :user='{{ $user }}' :sedes='{{ $sedes }}' :cur-user='{{ Auth::user() }}' view_mode='edit'/>
	@endif

@endsection
