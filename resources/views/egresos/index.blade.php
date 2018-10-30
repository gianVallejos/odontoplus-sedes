@extends('layout')

@section('content')
	
	<egresos-index url='{{ route("home") }}' :cur-user='{{ Auth::user() }}'  :egresos="{{ $egresos }}" />

@endsection
