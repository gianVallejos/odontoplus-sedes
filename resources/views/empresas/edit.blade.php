@extends('layout')

@section('content')
<empresa-form title = "Modificar Empresa" url='{{ route("home") }}' 
			  :record='{{ $empresa }}' :cur-user='{{ Auth::user() }}' view_mode='edit'/>
@endsection