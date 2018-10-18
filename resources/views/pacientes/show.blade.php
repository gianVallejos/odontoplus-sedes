@extends('layout')

@section('content')

	<paciente-form  title = "Detalle de Paciente" url='{{ route("home") }}' :paciente='{{ $paciente }}' 
					:cur-user='{{ Auth::user() }}' :empresas='{{ $empresas }}' view_mode='show' />
	
@endsection