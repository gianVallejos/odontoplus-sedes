@extends('layout')

@push('styles')
	<link rel="stylesheet" href="{{ asset('css/auth.css') }}" />
@endpush

@section('content')

<div class="container">
  <div class="overlay-green"></div>
  <div class="auth-box">
    <div class="card">
        <!--div class="card-header">{{ __('Reset Password') }}</div-->
        <div class="card-body">
					<div class="row">
					<div class="col-md-12">
								<div class="logotipo text-center">
										<a href="https://www.odontoplus.pe" target="_blank">
											<img src="{{ asset('images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png?v=1.0.1') }}" alt="Logotipo">
										</a>
								</div>
					</div>
					<div class="col-md-12 mb-2 mt-3 card-title">
						Recuperación de Contraseña
					</div>
					<div class="col-md-12">
					  @if (session('status'))
                <div class="alert alert-success mb-4 pr-2 pl-2" role="alert">
                    {{ session('status') }}
                </div>
            @endif
					</div>
					<div class="col-md-12">
            <form method="POST" action="{{ route('password.email') }}">
                @csrf
                <div class="form-group">
                    <div class="input-group">
                        <span class="icon-input">
                            <i class="fas fa-envelope"></i>
                        </span>
                        <input placeholder="Dirección de E-mail" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }} odInput" name="email" value="{{ old('email') }}" required>
													@if ($errors->has('email'))
                            <span class="invalid-feedback" role="alert">
                                {{ $errors->first('email') }}
                            </span>
													@endif
                    </div>
                </div>
                <div class="form-group">
                  <button type="submit" class="btn btn-primary btn-login">
                      Enviar Email de Recuperación
                  </button>
                </div>
            </form>
					</div>
				</div>

        </div>
    </div>

  </div>
	<div class='sign text-center'>
			<p>Software desarrollado por <a href="https://www.odontoplus.pe" target="_blank">Odontoplus</a> &copy; 2018 v. 3.1.0</p>
	</div>
</div>
@endsection
