@extends('layout')

@section('content')
<tratamientos :items = "{{ $tratamientos }}" :cur-user='{{ Auth::user() }}' url='{{ route("home") }}'/>
@endsection