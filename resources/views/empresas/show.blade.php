@extends('layout')

@section('content')
  <empresa-form title = "Detalle de Empresa" url='{{ route("home") }}' record='{{ $empresa }}' view_mode='show'/>
@endsection