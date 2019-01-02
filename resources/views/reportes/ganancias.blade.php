@extends('layout')

@section('content')
	<ganancias url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' />
@endsection