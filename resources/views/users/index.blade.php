@extends('layout')

@section('content')
	@if( Auth::user()->rolid == 1 || Auth::user()->rolid == 3 )
		<Users :items = "{{ $users }}" url='{{ route("home") }}'/>
	@endif
@endsection