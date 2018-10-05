@extends('layout')

@section('content')
<tratamiento-form title = "Modificar Tratamiento" url='{{ route("home") }}' record='{{ $tratamiento }}' view_mode='edit'/>
@endsection