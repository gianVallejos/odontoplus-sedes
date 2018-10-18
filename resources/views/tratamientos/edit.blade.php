@extends('layout')

@section('content')
<tratamiento-form title = "Modificar Tratamiento" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' :record='{{ $tratamiento }}' view_mode='edit'/>
@endsection