@extends('layout')

@section('content')
	
	<egresos-index url='{{ route("home") }}' :egresos="{{ $egresos }}" />

@endsection
