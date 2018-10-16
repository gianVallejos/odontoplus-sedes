@extends('layout')

@section('content')
<precios :treatments = "{{ $treatments }}" :companies = "{{ $companies }}"  :prices = "{{ $prices }}"  url='{{ route("home") }}'/>
@endsection