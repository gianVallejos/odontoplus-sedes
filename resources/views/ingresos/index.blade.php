@extends('layout')

@section('content')
	
	<ingresos-index url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' :ingresos="{{ $ingresos }}" />

@endsection
