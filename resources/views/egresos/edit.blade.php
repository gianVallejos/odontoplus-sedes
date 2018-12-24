@extends('layout')

@section('content')
	<egreso-form title = "Modificar de Egreso" url='{{ route("home") }}' :record='{{ $egreso }}'
							 :cur-user='{{ Auth::user() }}' view_mode='edit' :doctores="{{ $doctores }}" :sedes="{{ $sedes }}"/>
@endsection
