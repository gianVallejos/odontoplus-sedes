@extends('reporte')

@section('content')
	<pagos-reporte :ingresos='{{ $ingresos }}' :igeneral = '{{ $igeneral }}' url='{{ route("home") }}' view_mode = 'show' />
@endsection