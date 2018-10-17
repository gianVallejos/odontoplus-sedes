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
Route::resource('empresas', 'EmpresaController');
Route::resource('proveedores', 'ProveedorController');
Route::resource('proveedorLineItems', 'ProveedorLineItemController');
Route::resource('precios', 'PrecioController');
Route::get('consulta_precio', 'PrecioController@getPrice');

//REPORTS
Route::get('reportes', 'ReporteController@index');
Route::get('reportes/ingresos', 'ReporteController@incomes');
Route::get('reportes/ingresos/por_paciente', 'ReporteController@pacienteIncomes');
Route::get('reportes/ingresos/por_empresa', 'ReporteController@companyIncomes');
Route::get('reportes/egresos', 'ReporteController@outputs');
Route::get('reportes/balance', 'ReporteController@totalIncomesOutputs');
Route::get('reportes/tratamientos/destacados', 'ReporteController@treatments');

//APIS 
Route::resource('presupuestos', 'PresupuestoController');
Route::get('presupuestos/nuevo/{idPaciente}/{idDoctor}', 'PresupuestoController@nuevo');
Route::get('presupuestos/reporte/{id}', 'PresupuestoController@reporte');

Route::resource('ingresos', 'IngresoController');
Route::get('ingresos/line-item/{id}', 'IngresoController@lineItem')->name('ingresos.lineitem');
Route::post('ingresos/line-item', 'IngresoController@lineItemSave');
Route::put('ingresos/line-item/{id}', 'IngresoController@lineItemUpdate');
Route::delete('ingresos/line-item/{id}', 'IngresoController@lineItemDelete');

Route::resource('egresos', 'EgresoController');

//APIS 
Route::get('pacientes/{id}/{flag}', 'PacienteController@show');
Route::get('api-v1/op-obtener-pacientes', 'WsOdontoplusController@OP_obtenerPacientes')->name('pacientes.obtener');
Route::post('api-v1/op-crear-paciente', 'WsOdontoplusController@OP_crearPaciente')->name('paientes.crear');
Route::get('api-v1/op-obtener-paciente-id/{id}', 'WsOdontoplusController@OP_obtenerPacientes_Id')->name('pacientes.obtener.id');
Route::put('api-v1/op-actualizar-paciente-id/{id}', 'WsOdontoplusController@OP_actualizarPaciente_Id')->name('pacientes.actualizar');
Route::get('/api-v1/op-eliminar-paciente-id/{id}', 'WsOdontoplusController@OP_eliminarPaciente_Id');

//Presupuestos API
Route::get('/api-v1/op-obtener-presupuestos', 'WsOdontoplusController@OP_obtenerPresupuestos');
Route::post('/api-v1/save-nuevo-presupuesto', 'WsOdontoplusController@OP_saveNuevoPresupuesto');