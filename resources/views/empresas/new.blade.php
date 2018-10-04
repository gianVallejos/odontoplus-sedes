@extends('layout')

@section('content')
<empresa-form title = "Nueva Empresa" url='{{ route("home") }}' view_mode='new' />
@endsection