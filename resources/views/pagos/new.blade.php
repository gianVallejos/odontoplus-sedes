@extends('layout')

@section('content')
	<pagos-new :ingresos='{{ $ingresos }}' url='{{ route("home") }}' />
@endsection