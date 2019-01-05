@extends('layout')

@section('content')
<sede-form title = "Modificar Sede" url='{{ route("home") }}' 
			  :record='{{ $sede }}' :cur-user='{{ Auth::user() }}' view_mode='edit'/>
@endsection
