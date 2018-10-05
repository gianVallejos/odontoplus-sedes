@extends('layout')

@section('content')
	
	<presupuesto-nuevo  url='{{ route("home") }}' nro='{{ $lastPresupuesto }}' 
						:doctor="{{ $doctor }}" :paciente="{{ $paciente }}"
						:act_empresa="{{ $act_empresa }}" :precios="{{ $precios }}" :precios_table="{{ $precios_tabla }}"
						fechahora="{{ $fechahora }}" />
@endsection
