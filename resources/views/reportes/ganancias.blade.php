@extends('layout')

@section('content')
	<ganancias :items='{{ $ingresos }}' url='{{ route("home") }}' />
@endsection