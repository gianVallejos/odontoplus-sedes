@extends('layout')

@section('content')

	<ganancias url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' :is_admin_sede='{{ $is_admin_sede }}' :sedes='{{ $sedes }}' />

@endsection
