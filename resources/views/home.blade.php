@extends('layout')

@section('content')

	<Dashboard url='{{ route("home") }}' :is_admin_sede="{{ $is_admin_sede }}" :pacientes="{{ $pacientes }}" :sedes="{{ $sedes }}" :user='{{ Auth::user() }}' />

@endsection
