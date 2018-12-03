@extends('layout')

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
							<a href="https://www.odontoplus.pe" target="_blank">
								<img src="{{ asset('images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png?v=1.0.1') }}" alt="Logotipo">
							</a>
						</div>
					</div>

					<div class="col-md-12 mb-2 mt-3 card-title">
						Recuperación de Contraseña
					</div>

					<div class="col-md-12">
						<form method="POST" action="{{ route('password.update') }}">
								@csrf

								<input type="hidden" name="token" value="{{ $token }}">

								<div class="form-group">
									<div class="input-group">
										<span class="icon-input">
												<i class="fas fa-envelope"></i>
										</span>
										<input id="email" placeholder="Dirección de E-mail" class="form-control{{ $errors->has('email') ? ' is-invalid' : '' }} odInput" name="email" value="{{ $email ?? old('email') }}" required autofocus>
										@if ($errors->has('email'))
												<span class="invalid-feedback" role="alert">
														<strong>{{ $errors->first('email') }}</strong>
												</span>
										@endif
									</div>
								</div>

								<div class="form-group">
									<div class="input-group">
										<span class="icon-input">
												<i class="fas fa-lock"></i>
										</span>
										<input id="password" type="password" placeholder="Contraseña" class="form-control{{ $errors->has('password') ? ' is-invalid' : '' }} odInput" name="password" autocomplete="off" required>
										@if ($errors->has('password'))
												<span class="invalid-feedback" role="alert">
														<strong>{{ $errors->first('password') }}</strong>
												</span>
										@endif
									</div>
								</div>

								<div class="form-group">
									<div class="input-group">
										<span class="icon-input">
												<i class="fas fa-lock"></i>
										</span>
										<input id="password-confirm" type="password"  placeholder="Confirmar Contraseña" class="form-control" name="password_confirmation" required>
									</div>
								</div>

								<div class="form-group">
									<button type="submit" class="btn btn-primary btn-login">
										Actualizar Contraseña
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
