@extends('layout')

<!-- Push a style dynamically from a view -->
@push('styles')
	<link rel="stylesheet" href="{{ asset('css/auth.css') }}" />
@endpush


@section('content')
<div class="container">
    <div class="auth-box">
        <form method="POST" action="{{ route('login') }}">
        @csrf
            <div class='row logotype'>
                <div class='col-md-12 pt-4 pb-4'>
                    <img src="{{ asset('images/empresa/logo.jpeg') }}" alt="">
                </div>
            </div>
            <div class='row body'>
                <div class="form-group col-md-12">
                    <input id="email" type="email" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }}" name="email" value="{{ old('email') }}" required autofocus>
                    @if ($errors->has('email'))
                        <span class="invalid-feedback" role="alert">
                            <strong>{{ $errors->first('email') }}</strong>
                        </span>
                    @endif
                </div>
                <div class='form-group col-md-12'>
                    <input id="password" type="password" class="form-control{{ $errors->has('password') ? ' is-invalid' : '' }}" name="password" required>
                    @if ($errors->has('password'))
                        <span class="invalid-feedback" role="alert">
                            <strong>{{ $errors->first('password') }}</strong>
                        </span>
                    @endif
                </div>
                <div class='form-group col-md-12'>
                    <button type="submit" class="btn btn-primary btn-lg btn-block btn-login">
                        Iniciar Sesión
                    </button>
                </div>
                
            </div>
            <div class='row footer'>
                <div class="col-md-6 text-left ">
                    <div class="form-check ">
                        <input class="form-check-input " type="checkbox" name="remember" id="remember" {{ old('remember') ? 'checked' : '' }}>
                        <label class="form-check-label " for="remember">
                            Recordarme
                        </label>
                    </div>
                </div>
                <div class="col-md-6 text-right align-middle">
                    <a class="btn btn-link remember-lnk" href="{{ route('password.request') }}">
                        ¿Olvidaste tu contraseña?
                    </a>
                </div>
            </div>
        </form>
        <div class='sign text-center'>
            <p>Desarrollado por <span>Odontoplus</span> ® 2018 v. 1.0.1</p>
        </div>
    </div>

</div>
@endsection
