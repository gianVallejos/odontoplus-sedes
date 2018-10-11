@extends('layout')

@section('content')
	<egreso-form title = "Modificar de Egreso" url='{{ route("home") }}' :record='{{ $egreso }}' view_mode='edit' :doctores="{{ $doctores }}" />
@endsection