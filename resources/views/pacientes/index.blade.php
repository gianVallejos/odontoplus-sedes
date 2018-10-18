@extends('layout')

@section('content')
	<Pacientes :items='{{ $pacientes }}' url='{{ route("home") }}' />
@endsection