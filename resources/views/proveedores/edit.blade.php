@extends('layout')

@section('content')
<proveedor-form title = "Modificar Proveedor/Laboratorio" url='{{ route("home") }}' record='{{ $proveedor }}' view_mode='edit'/>
@endsection