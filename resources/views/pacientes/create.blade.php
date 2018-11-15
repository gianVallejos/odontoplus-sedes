@extends('layout')

@section('content')
	<paciente-form title = "Nuevo Paciente" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}'
								 :empresas='{{ $empresas }}' :referencias='{{ $referencias }}' view_mode='new' />
@endsection
