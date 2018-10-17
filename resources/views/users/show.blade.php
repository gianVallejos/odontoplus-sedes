@extends('layout')

@section('content')

	@if( Auth::user()->id == $id || Auth::user()->rolid == 1 )
 		<user-form title = "Detalle de Usuario" url='{{ route("home") }}' :user='{{ $user }}' :cur-user='{{ Auth::user() }}' view_mode='show' />
 	@endif
@endsection