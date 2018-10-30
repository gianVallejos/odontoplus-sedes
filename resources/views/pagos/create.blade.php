@extends('layout')

@section('content')
	<pagos-form url='{{ route("home") }}' :doctores='{{ $doctores }}' :cur-user='{{ Auth::user() }}' />
@endsection