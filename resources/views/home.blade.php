@extends('layout')

@section('content')

	<Dashboard url='{{ route("home") }}' :pacientes="{{ $pacientes }}" :sedes="{{ $sedes }}" :user='{{ Auth::user() }}' />

@endsection
