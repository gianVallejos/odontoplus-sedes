const mix = require('laravel-mix');

mix.js('resources/assets/js/app.js', 'public/js/app.js');
mix.stylus('resources/assets/stylus/odontoplus.styl', 'public/css');
mix.stylus('resources/assets/stylus/header.styl', 'public/css');
mix.stylus('resources/assets/stylus/dashboard.styl', 'public/css');
mix.stylus('resources/assets/stylus/auth.styl', 'public/css');
mix.stylus('resources/assets/stylus/diente.styl', 'public/css');