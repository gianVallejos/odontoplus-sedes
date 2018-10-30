@extends('layout')

@section('content')
<empresas :items = "{{ $empresas }}" :cur-user='{{ Auth::user() }}' url='{{ route("home") }}'/>
@endsection