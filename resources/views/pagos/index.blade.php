@extends('layout')

@section('content')
	<pagos :items='{{ $pagos }}' url='{{ route("home") }}' />
@endsection