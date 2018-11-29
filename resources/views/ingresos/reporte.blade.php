@extends('reporte')

@section('content')
	<ingreso-reporte url='{{ route("home") }}' :igeneral='{{ $igeneral }}' :cur-user='{{ Auth::user() }}' :idetalle='{{ $idetalle }}' :cliente="{{ $cliente }}" />
@endsection
