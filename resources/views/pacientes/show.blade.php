@extends('layout')

@section('content')
	<paciente-show url='{{ route("home") }}' actual-id='{{ $id }}' :empresas="{{ $empresas }}" :flag="{{ $flag }}" />
@endsection