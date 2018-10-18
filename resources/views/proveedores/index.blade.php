@extends('layout')

@section('content')
<proveedores :items = "{{ $proveedores }}" url='{{ route("home") }}'/>
@endsection