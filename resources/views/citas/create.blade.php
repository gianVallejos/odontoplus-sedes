@extends('layout')
<script>
    var global_url = "{{ route('home') }}";
</script>
@section('content')
  <cita-form title = "Nueva Cita" url='{{ route("home") }}' :pacientes="{{ $pacientes }}" :sillons="{{ $sillons }}"
             :doctores="{{ $doctores }}" :sedes="{{ $sedes }}" :cur-user='{{ Auth::user() }}' view_mode='new' />
@endsection
