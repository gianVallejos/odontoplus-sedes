@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 )
		<reportes url='{{ route("home") }}' :sedes='{{ $sedes }}' />
	@endif
@endsection
