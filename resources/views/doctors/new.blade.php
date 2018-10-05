@extends('layout')

@section('content')
<doctor-form title = "Nuevo Doctor" url='{{ route("home") }}' view_mode='new' />
@endsection