@extends('reporte')

@section('content')
	<pagos-new :ingresos='{{ $ingresos }}' :igeneral = '{{ $igeneral }}' url='{{ route("home") }}' view_mode = 'new' />
@endsection