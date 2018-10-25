@extends('layout')

@section('content')
<precios :companies = "{{ $companies }}"  :prices = "{{ $prices }}" :cur-user='{{ Auth::user() }}' url='{{ route("home") }}'/>
@endsection