@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 )
		<user-form title = "Nuevo Usuario" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' view_mode='new' />
	@endif
	
@endsection