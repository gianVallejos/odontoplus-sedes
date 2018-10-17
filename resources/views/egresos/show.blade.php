@extends('layout')

@section('content')
  <egreso-form title = "Detalle de Egreso" url='{{ route("home") }}' :record='{{ $egreso }}' :cur-user='{{ Auth::user() }}' view_mode='show' :doctores="{{ $doctores }}" />
@endsection