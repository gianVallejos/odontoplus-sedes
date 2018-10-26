@extends('reporte')

@section('content')
	<pagos-ganancias :ingresos='{{ $ingresos }}' :igeneral = '{{ $igeneral }}' url='{{ route("home") }}' view_mode = 'new' />
@endsection