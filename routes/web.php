<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'HomeController@index')->name('home');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('dashboard');
Route::get('/container-general', 'HomeController@containerGeneral');
Route::resource('users', 'UserController');
Route::resource('pacientes', 'PacienteController');
//APIS 
Route::get('api-v1/op-obtener-pacientes', 'WsOdontoplusController@OP_obtenerPacientes');
Route::post('api-v1/op-crear-paciente', 'WsOdontoplusController@OP_crearPaciente');
Route::get('api-v1/op-obtener-paciente-id/{id}', 'WsOdontoplusController@OP_obtenerPacientes_Id');