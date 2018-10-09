@extends('layout')

@section('content')
	<ingreso-form title = "Modificar de Ingreso" url='{{ route("home") }}' :record='{{ $ingreso }}' view_mode='edit' :doctores="{{ $doctores }}" :pacientes="{{ $pacientes }}"/>
@endsection