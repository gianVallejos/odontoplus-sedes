@extends('layout')

@section('content')
		<paciente-form title = "Modificar Paciente" url='{{ route("home") }}' :paciente='{{ $paciente }}' :cur-user='{{ Auth::user() }}'
									 :empresas='{{ $empresas }}' :referencias='{{ $referencias }}' :sedes='{{ $sedes }}' view_mode='edit'/>
@endsection
