@extends('layout')

@section('content')
	<paciente-form title = "Nuevo Paciente" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' :empresas='{{ $empresas }}' view_mode='new' />
@endsection
