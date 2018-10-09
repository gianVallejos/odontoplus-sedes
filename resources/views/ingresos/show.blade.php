@extends('layout')

@section('content')
  <ingreso-form title = "Detalle de Ingreso" url='{{ route("home") }}' :record='{{ $ingreso }}' view_mode='show' :doctores="{{ $doctores }}" :pacientes="{{ $pacientes }}"/>
@endsection