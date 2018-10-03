@extends('layout')

@section('content')
<doctor-form title = "Modificar Doctor" url='{{ route("home") }}' record='{{ $doctor }}' view_mode='edit'/>
@endsection