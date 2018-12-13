@extends('layout')

@section('content')
  <cita-form title = "Nueva Cita" url='{{ route("home") }}' :pacientes="{{ $pacientes }}" :doctores="{{ $doctores }}" :cur-user='{{ Auth::user() }}' view_mode='new' />
@endsection
