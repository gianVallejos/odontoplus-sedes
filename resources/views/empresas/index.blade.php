@extends('layout')

@section('content')
<empresas :items = "{{ $empresas }}" url='{{ route("home") }}'/>
@endsection