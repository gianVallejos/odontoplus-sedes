@extends('layout')



@section('content')
  <Users :items = "{{ $users }}"/>
@endsection