@extends('layout')

@section('content')

	<Dashboard url='{{ route("home") }}' :pacientes="{{ $last_pacientes }}" :presupuestos="{{ $last_presupuestos }}" :user='{{ Auth::user() }}' />

@endsection
