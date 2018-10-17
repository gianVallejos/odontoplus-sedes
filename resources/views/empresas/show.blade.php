@extends('layout')

@section('content')
  <empresa-form title = "Detalle de Empresa" url='{{ route("home") }}' 
  				:record='{{ $empresa }}' :cur-user='{{ Auth::user() }}' 
  				view_mode='show'/>
@endsection