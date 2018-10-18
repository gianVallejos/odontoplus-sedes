@extends('layout')

@section('content')
  <tratamiento-form title = "Detalle de Tratamiento" url='{{ route("home") }}':cur-user='{{ Auth::user() }}' :record='{{ $tratamiento }}' view_mode='show'/>
@endsection