@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 || Auth::user()->rolid == 3)
		<reportes url='{{ route("home") }}' :is_admin_sede='{{$is_admin_sede}}' :sedes='{{ $sedes }}' />
	@endif
@endsection
