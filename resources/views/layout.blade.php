<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="csrf-token" content="{{ csrf_token() }}">
	<title>
		Odontoplus - Software Odontológico
	</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css">
	<link href="https://fonts.googleapis.com/css?family=Open+Sans|Rubik" rel="stylesheet">
	
	<link rel="stylesheet" href="{{ asset('css/odontoplus.css?v=1.0.17') }}">
	<link rel="stylesheet" href="{{ asset('css/header.css?v=1.0.1') }}">
	<link rel="stylesheet" href="{{ asset('css/dashboard.css') }}">
	<link rel="stylesheet" href="{{ asset('css/auth.css') }}" />
	<link rel="stylesheet" href="{{ asset('css/diente.css?v=1.0.5') }}" />

	<!--Dynamic StyleSheets added from a view would be pasted here-->
	@yield('styles')
</head>
<body>	
	<div id="header">
	@if( Auth::check() )	
		<header-component 
			user-name='{{ Auth::user()->name }}' 
			logout-route='{{ route("logout") }}'
			url='{{ route("home") }}'
		>
		</header-component>
		<nav-component url='{{ route("home") }}' />
	@endif
	</div>

	<div id="alert">
		@if(Session::has('alert'))
			<flash ref="flash_alert" alert="{{ Session::get('alert') }}"/>
		@endif
	</div>

	<div id="app">
		<div class="contenido">
			@yield('content')
		</div>
	</div>
	
	<div id="footer">
	@if( Auth::check() )	
		<footer-component></footer-component>			
	@endif
	</div>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<script src="{{ asset('js/app.js?v=1.0.17') }}"></script>
</body>
</html>