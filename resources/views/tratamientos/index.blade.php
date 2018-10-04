@extends('layout')

@section('content')
<tratamientos :items = "{{ $tratamientos }}" url='{{ route("home") }}'/>
@endsection