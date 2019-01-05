@extends('layout')

@section('content')
<sedes :items = "{{ $sedes }}" :cur-user='{{ Auth::user() }}' url='{{ route("home") }}'/>
@endsection
