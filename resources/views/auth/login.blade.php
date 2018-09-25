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
                            <img src="{{ asset('images/empresa/logotipo-blue.png') }}" alt="Logotipo">
                        </div>
                    </div>
                    <div class="col-md-12">
                        <form method="POST" action="{{ route('login') }}">
                            @csrf
                            <div class="form-group">
                                <div class="input-group">
                                    <span class="icon-input">
                                        <i class="fas fa-envelope"></i>
                                    </span>                                
                                    <input type="email" placeholder="Dirección de E-mail" class="odInput{{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" value="{{ old('email') }}" required>
                                    @if ($errors->has('email'))
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $errors->first('email') }}</strong>
                                        </span>
                                    @endif
                                </div>
                            </div>
                            <div class='form-group'>
                                <div class="input-group">
                                    <span class="icon-input">
                                        <i class="fas fa-lock"></i>
                                    </span> 
                                    <input type="password" placeholder="Contraseña" class="odInput{{ $errors->has('password') ? ' is-invalid' : '' }}" name="password" required>
                                    @if ($errors->has('password'))
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{ $errors->first('password') }}</strong>
                                        </span>
                                    @endif
                                </div>
                            </div>                            
                            <div class='form-group'>
                                <button type="submit" class="btn btn-primary btn-login">
                                    Iniciar Sesión
                                </button>
                            </div>
                            <div class="login-bottom">
                                <div class="d-inline-block">
                                    <input style="margin-top: 2px" type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                                    <div class="d-inline-block">No cerrar sesión</div>
                                </div>
                                <div class="d-inline-block" style="float: right">
                                    <a href="{{ route('password.request') }}">
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
            <p>Desarrollado por <a href="https://www.odontoplus.pe" target="_blank">Odontoplus</a> &copy; 2018 v. 3.0.0</p>
    </div>

</div>
@endsection
