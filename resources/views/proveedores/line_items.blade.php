@extends('layout')

@section('content')
  <proveedor-line-items url='{{ route("home") }}' data='{{ $data }}' />
@endsection