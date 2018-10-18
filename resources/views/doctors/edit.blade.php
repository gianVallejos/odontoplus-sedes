@extends('layout')

@section('content')
<doctor-form title = "Modificar Doctor" url='{{ route("home") }}' :record='{{ $doctor }}' :cur-user='{{ Auth::user() }}' view_mode='edit'/>
@endsection