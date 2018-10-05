@extends('layout')

@section('content')

	<presupuesto-create url='{{ route("home") }}' :pacientes="{{ $pacientes }}" :doctores="{{ $doctores }}" />

@endsection