@extends('layout')

@section('content')
	<ingreso-form title = "Nuevo Ingreso" url='{{ route("home") }}' view_mode='new' :doctores="{{ $doctores }}" :pacientes="{{ $pacientes }}" />
@endsection