@extends('layout')

@section('content')
<user-form title = "Nuevo Usuario" url='{{ route("home") }}' display='new' />
@endsection