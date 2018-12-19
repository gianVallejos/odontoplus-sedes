@extends('layout')
<script>
    var global_url = "{{ route('home') }}";
</script>
@section('content')
<div class="container pb-4">
  <div class="row">
    <div class="col-12">
      <ol class="breadcrumb">
        <li role="presentation" class="breadcrumb-item">
          <a href="#" target="_self">INICIO</a>
        </li>
        <li role="presentation" class="breadcrumb-item active">
          <span aria-current="location">CITAS</span>
        </li>
      </ol>
    </div>
    <div class="col-12 pt-1">
      <div class="card">
    		<div class="card-heading">
    			<span>Calendario de Citas</span>
    		</div>
    		<div class="card-body pt-3 pb-3 pl-3 pr-3">
          <div class="row pb-3">
            <!-- <div class="col-md-12 pt-3 pb-3 mb-3">
              <div class="float-right d-inline-block">
                <a href="#" target="_self" class="btn btn-success">
                  <i class="fas fa-plus"></i> Nuevo Paciente
                </a>
              </div>
            </div> -->

            <div class="col-md-4 pr-4 pl-4 pt-2 pb-4">
              <div class="float-left input-group" role="group">
                <div class="input-group-prepend">
                  <div class="input-group-text fz-4"> Doctor </div>
                </div>
                <select class="form-control" name="id_doctor">
                  <option value="all" selected>Todos</option>
                  @foreach($doctores as $dr)
                    <option value="{{ $dr->id }}">{{ $dr->nombres.' '.$dr->apellidos }}</option>
                  @endforeach
                </select>
              </div>
            </div>


            <!--select id="dropdown">
              <option value="All" data-feed="all-feed.php" selected>All</option>
              <option value="This" data-feed="this-feed.php">This</option>
              <option value="That" data-feed="that-feed.php">That</option>
            </select-->

            <div class="col-md-12 pr-4 pl-4">
              <div id='calendar'></div>
            </div>
          </div>
    		</div>
    		<div class="card-footer">
    			<slot name="footer"></slot>
    		</div>
    	</div>
    </div>
  </div>
</div>
@endsection
