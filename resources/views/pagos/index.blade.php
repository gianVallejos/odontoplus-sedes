@extends('layout')

@section('content')
	<pagos :items='{{ $pagos }}' url='{{ route("home") }}'  :cur-user='{{ Auth::user() }}' />
@endsection