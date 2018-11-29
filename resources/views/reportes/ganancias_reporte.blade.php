@extends('reporte')

@section('content')
	<ganancias-reporte :ingresos='{{ $ingresos }}' :igeneral = '{{ $igeneral }}' url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' view_mode = 'new' :cliente="{{ $cliente }}"/>
@endsection
