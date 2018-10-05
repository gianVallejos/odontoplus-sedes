@extends('layout')

@section('content')
<user-form title = "Modificar Usuario" url='{{ route("home") }}' user='{{ $user }}' display='edit'/>
@endsection