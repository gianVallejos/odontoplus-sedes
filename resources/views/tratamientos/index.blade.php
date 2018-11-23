@extends('layout')

@section('content')
<tratamientos :items = "{{ $tratamientos }}" :pacientes="{{ $pacientes }}" :cur-user='{{ Auth::user() }}' url='{{ route("home") }}'/>
@endsection
