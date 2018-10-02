@extends('layout')

@section('content')
	<presupuesto-nuevo url='{{ route("home") }}' nro='{{ $lastPresupuesto }}' />
@endsection
