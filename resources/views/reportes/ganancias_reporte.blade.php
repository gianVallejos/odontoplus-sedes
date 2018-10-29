@extends('reporte')

@section('content')
	<ganancias-reporte :ingresos='{{ $ingresos }}' :igeneral = '{{ $igeneral }}' url='{{ route("home") }}' view_mode = 'new' />
@endsection