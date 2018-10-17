@extends('layout')

@section('content')
<precios :companies = "{{ $companies }}"  :prices = "{{ $prices }}"  url='{{ route("home") }}'/>
@endsection