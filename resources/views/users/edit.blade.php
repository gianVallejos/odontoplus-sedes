@extends('layout')

@section('content')

	@if( Auth::user()->rolid == 1 || Auth::user()->rolid == 3 )
		<user-form title = "Modificar Usuario" url='{{ route("home") }}'  :is_admin_sede='{{ $is_admin_sede }}' :user='{{ $user }}' :sedes='{{ $sedes }}' :cur-user='{{ Auth::user() }}' view_mode='edit'/>
	@endif

@endsection
