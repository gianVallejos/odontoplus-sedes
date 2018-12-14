@extends('layout')
<script>
    var global_url = "{{ route('home') }}";
</script>
@section('content')
  <cita-form title = "Detalle de Cita" url='{{ route("home") }}' :record='{{ $cita }}' :pacientes="{{ $pacientes }}" :doctores="{{ $doctores }}" :cur-user='{{ Auth::user() }}' view_mode='show'/>
@endsection
