@extends('layout')

@section('content')
	
	<paciente-create items="" url='{{ route("home") }}' :empresas='{{ $empresas }}' />

@endsection
