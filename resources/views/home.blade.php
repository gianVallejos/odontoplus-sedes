@extends('layout')

@section('content')

	<Dashboard url='{{ route("home") }}' :pacientes="{{ $pacientes }}" :user='{{ Auth::user() }}' />

@endsection
