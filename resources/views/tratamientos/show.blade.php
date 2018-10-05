@extends('layout')

@section('content')
  <tratamiento-form title = "Detalle de Tratamiento" url='{{ route("home") }}' record='{{ $tratamiento }}' view_mode='show'/>
@endsection