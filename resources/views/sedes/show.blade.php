@extends('layout')

@section('content')
  <sede-form title = "Detalle de Sede" url='{{ route("home") }}'
  				:record='{{ $sede }}' :cur-user='{{ Auth::user() }}' view_mode='show'/>
@endsection
