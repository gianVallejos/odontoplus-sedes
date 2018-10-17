@extends('layout')

@section('content')
	<Doctores :items = "{{ $doctors }}" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}'/>
@endsection