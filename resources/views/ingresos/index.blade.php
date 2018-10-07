@extends('layout')

@section('content')
	
	<ingresos-index url='{{ route("home") }}' :ingresos="{{ $ingresos }}" />

@endsection
