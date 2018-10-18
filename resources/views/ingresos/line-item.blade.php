@extends('layout')

@section('content')

  	<ingreso-line-item title="Detalle de Ingreso" url='{{ route("home") }}' 
  					   :record="{{ $ingresos }}" :record-detail="{{ $ingreso_detalle }}" :cur-user='{{ Auth::user() }}' :tratamientos="{{ $tratamientos }}" />
	
@endsection