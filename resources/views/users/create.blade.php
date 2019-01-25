@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 )
		<user-form title = "Nuevo Usuario" url='{{ route("home") }}' :sedes='{{ $sedes }}' :cur-user='{{ Auth::user() }}' view_mode='new' />
	@endif

@endsection
