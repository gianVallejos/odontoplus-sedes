@extends('layout')

@section('content')
<Users :items = "{{ $users }}" url='{{ route("home") }}'/>
@endsection