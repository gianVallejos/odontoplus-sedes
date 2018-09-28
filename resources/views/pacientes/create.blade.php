@extends('layout')

@section('content')
	
	<paciente-create url='{{ route("home") }}' :empresas='{{ $empresas }}' />

@endsection
