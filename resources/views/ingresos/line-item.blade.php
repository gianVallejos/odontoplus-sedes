@extends('layout')

@section('content')
  	<ingreso-line-item title="Detalle de Ingreso" url='{{ route("home") }}'
  					   :record="{{ $ingresos }}" :record-detail="{{ $ingreso_detalle }}"
               :doctores="{{ $doctores }}"
  					   :sedes="{{ $sedes }}"
  					   :cur-user='{{ Auth::user() }}'
               :tratamientos="{{ $tratamientos }}"
               :presupuestos-by-ingreso="{{ $presupuestos_by_ingreso }}" />

@endsection
