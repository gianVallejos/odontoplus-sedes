@extends('layout')

@section('content')
	
	<paciente-index :items="{{ $data }}" url='{{ route("home") }}' />

@endsection
