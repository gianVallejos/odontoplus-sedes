@extends('layout')
<script>
    var global_url = "{{ route('home') }}";
</script>
@section('content')
<div class="container pb-4">
  <div class="row">
    <div id="spinner" class="spinnerActive">
      <?php
        $ruta = route('home') . '/images/spinner.gif';
      ?>
      <img src="{{ $ruta }}" widt="75" height="75" alt="Cargando..."/>
    </div>

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

            <div class="col-lg-5 col-md-6 pl-4 pt-2 pb-4">
              <div class="float-left input-group">
                <div class="input-group-prepend">
                  <div class="input-group-text fz-4"> Doctor </div>
                </div>
                <select class="form-control" name="id_doctor">
                  <option value="all" selected>Todos los doctores</option>
                  @foreach($doctores as $dr)
                    <option value="{{ $dr->id }}">{{ $dr->nombres.' '.$dr->apellidos }}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-lg-4 col-md-6 pl-4 pt-2 pb-4">
              <div class="float-left input-group">
                <div class="input-group-prepend">
                  <div class="input-group-text fz-4"> Sede </div>
                </div>
                <select class="form-control" name="id_sede">
                  <option value="all" selected>Todas las sedes</option>
                  @foreach($sedes as $sede)
                    <option value="{{ $sede->id }}">{{ $sede->nombre }}</option>
                  @endforeach
                </select>
              </div>
            </div>

            <div class="col-md-12 pr-4 pl-4 ">
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

<Style>
.spinnerActive{
    position: fixed;
    background: rgba(0, 0, 0, .2);
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    top: 0;
    left: 0;
    z-index: 999;
}
</style>
