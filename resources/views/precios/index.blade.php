@extends('layout')

@section('content')
<precios :items = "{{ $prices }}" url='{{ route("home") }}'/>
@endsection