@extends('layout')

@section('content')
  <doctor-form title = "Detalle de Doctor" url='{{ route("home") }}' record='{{ $doctor }}' view_mode='show'/>
@endsection