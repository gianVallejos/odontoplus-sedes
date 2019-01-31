@extends('layout')

<!-- Push a style dynamically from a view -->
@push('styles')
	<link rel="stylesheet" href="{{ asset('css/auth.css') }}" />
@endpush


@section('content')

<div class="container">
    <div class="overlay-green"></div>
    <div class="auth-box">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="logotipo text-center">
														<a href="{{ url('/') }}">
                            	<img src="{{ asset('images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png?v=1.0.1') }}" alt="Logotipo">
														</a>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <form method="POST" action="{{ route('login') }}">
                            {{ csrf_field() }}
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="icon-input">
                                        <i class="fas fa-envelope"></i>
                                    </span>
                                    <input placeholder="Dirección de E-mail" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }} odInput" name="email" value="{{ old('email') }}" >

                                        <span class="invalid-feedback" role="alert">
                                            {{ $errors->first('email') }}
                                        </span>
                                </div>
                            </div>
                            <div class='form-group'>
                                <div class="input-group">
                                    <span class="icon-input">
                                        <i class="fas fa-lock"></i>
                                    </span>
                                    <input type="password" placeholder="Contraseña" class="form-control odInput{{ $errors->has('password') ? ' is-invalid' : '' }}" name="password" autocomplete="off">
                                    @if ($errors->has('password'))
                                        <span class="invalid-feedback" role="alert">
                                            {{ $errors->first('password') }}
                                        </span>
                                    @endif
                                </div>
                            </div>
                            <div class='form-group'>
                                <button type="submit" class="btn btn-primary btn-login">
                                    Iniciar sesión
                                </button>
                            </div>
                            <div class="login-bottom">
                                <div class="d-inline-block">
                                    <input style="margin-top: 2px" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                                    <label class="d-inline-block mb-0" for="remember">No cerrar sesión</label>
                                </div>
                                <div class="d-inline-block" style="float: right">
                                    <a href="{{ url('/') }}/password/reset">
                                        ¿Olvidaste tu contraseña?
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div class='sign text-center'>
        <p>Software desarrollado por <a href="https://www.odontoplus.pe" target="_blank">Odontoplus</a> &copy; 2018 v. 3.1.12</p>
    </div>

</div>
<div id="exampleModal" class="modal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">¿Olvidaste tu contraseña?</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body pt-4 pb-4 pr-5 pl-5">
        <p class="text-justify">
            Odontoplus es un software de odontología que se preocupa por la seguridad de nuestros usuarios. Por lo tanto, para poder recuperar tu contraseña debes comunicarte con el propietario del software quien a través de su cuenta, en el módulo de usuarios, puede cambiar tu contraseña. No obstante, si eres uno de los propietarios del software y has perdido tu contraseña, contáctate con el área de soporte de <a href="www.odontoplus.pe" target="_blank">Odontoplus.</a>
        </p>
      </div>
    </div>
  </div>
</div>

@endsection
