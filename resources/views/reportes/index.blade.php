@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 )
		<reportes url='{{ route("home") }}' />
	@endif
@endsection