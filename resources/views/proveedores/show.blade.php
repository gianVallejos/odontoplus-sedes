@extends('layout')

@section('content')
  <proveedor-form title = "Detalle de Proveedor/Laboratorio" url='{{ route("home") }}' record='{{ $proveedor }}' view_mode='show'/>
@endsection