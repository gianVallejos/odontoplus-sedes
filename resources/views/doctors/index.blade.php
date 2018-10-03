@extends('layout')

@section('content')
<Doctores :items = "{{ $doctors }}" url='{{ route("home") }}'/>
@endsection