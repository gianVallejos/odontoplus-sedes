@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 )
		<Users :items = "{{ $users }}" url='{{ route("home") }}'/>
	@endif
@endsection