@extends('layout')

@section('content')
	
	<presupuesto-index url='{{ route("home") }}' :mydata='{{ $mydata }}' />

@endsection
