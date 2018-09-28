@extends('layout')

@section('content')
	
	<paciente-index url='{{ route("home") }}' status='{{ session("status") }}' />

@endsection
