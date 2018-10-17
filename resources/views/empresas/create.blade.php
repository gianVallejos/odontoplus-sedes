@extends('layout')

@section('content')
<empresa-form title = "Nueva Empresa" url='{{ route("home") }}' :cur-user='{{ Auth::user() }}' view_mode='new' />
@endsection