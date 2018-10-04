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
Route::resource('doctores', 'DoctorController');
Route::resource('pacientes', 'PacienteController');
Route::resource('tratamientos', 'TratamientoController');
//APIS 
Route::get('pacientes/{id}/{flag}', 'PacienteController@show');
Route::get('api-v1/op-obtener-pacientes', 'WsOdontoplusController@OP_obtenerPacientes')->name('pacientes.obtener');
Route::post('api-v1/op-crear-paciente', 'WsOdontoplusController@OP_crearPaciente')->name('paientes.crear');
Route::get('api-v1/op-obtener-paciente-id/{id}', 'WsOdontoplusController@OP_obtenerPacientes_Id')->name('pacientes.obtener.id');
Route::put('api-v1/op-actualizar-paciente-id/{id}', 'WsOdontoplusController@OP_actualizarPaciente_Id')->name('pacientes.actualizar');
Route::get('/api-v1/op-eliminar-paciente-id/{id}', 'WsOdontoplusController@OP_eliminarPaciente_Id');