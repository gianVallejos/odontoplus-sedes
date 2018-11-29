@extends('reporte')

@section('content')
	<pagos-reporte :ingresos='{{ $ingresos }}' :igeneral = '{{ $igeneral }}' url='{{ route("home") }}'  :cur-user='{{ Auth::user() }}' view_mode = 'show' :cliente="{{ $cliente }}" />
@endsection
