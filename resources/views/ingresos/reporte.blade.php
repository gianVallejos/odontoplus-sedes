@extends('reporte')

@section('content')
	<ingreso-reporte url='{{ route("home") }}' :igeneral='{{ $igeneral }}' :cur-user='{{ Auth::user() }}'
									:idetalle='{{ $idetalle }}' :paciente_sede="{{ $paciente_sede }}" />
@endsection
