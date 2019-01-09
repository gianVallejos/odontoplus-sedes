@extends('layout')

@section('content')
	<paciente-form title = "Nuevo Paciente" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}'
								 :empresas='{{ $empresas }}' :referencias='{{ $referencias }}'
								 :sedes='{{ $sedes }}' :codigo='{{ $codigo }}' view_mode='new' />
@endsection
