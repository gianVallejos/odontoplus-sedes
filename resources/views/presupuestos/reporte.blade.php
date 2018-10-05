@extends('reporte')

@section('content')
	
	<presupuesto-reporte url='{{ route("home") }}' :pgeneral="{{ $pres_general }}" :pdetalle="{{ $pres_detalle }}" :precios="{{ $precios }}" />

@endsection
