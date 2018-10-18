@extends('layout')

@section('content')
  <doctor-form title = "Detalle de Doctor" url='{{ route("home") }}' :record='{{ $doctor }}' :cur-user='{{ Auth::user() }}' view_mode='show'/>
@endsection