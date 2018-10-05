@extends('layout')

@section('content')
  <user-form title = "Detalle de Usuario" url='{{ route("home") }}' user='{{ $user }}' display='show'/>
@endsection