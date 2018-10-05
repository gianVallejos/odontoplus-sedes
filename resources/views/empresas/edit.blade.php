@extends('layout')

@section('content')
<empresa-form title = "Modificar Empresa" url='{{ route("home") }}' record='{{ $empresa }}' view_mode='edit'/>
@endsection