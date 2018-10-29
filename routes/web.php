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
Route::resource('pagos', 'PagoController');
Route::get('pagos/nuevo/{idDoctor}/{fechaInicial}/{fechaFinal}', 'PagoController@nuevoPagoReporte');
Route::get('pagos/detalle/{idDoctor}/{fechaInicial}/{fechaFinal}', 'PagoController@show');
Route::get('consulta_precio', 'PrecioController@getPrice');

//REPORTS
Route::get('reportes', 'ReporteController@index');
Route::get('reportes/ingresos/{date}', 'ReporteController@ingresos');
Route::get('reportes/obtener-ingresos-paciente', 'ReporteController@obtenerIngresosPaciente');
Route::get('reportes/obtener-ingresos-paciente/{start}/{end}', 'ReporteController@obtenerIngresosPacienteFechas');
Route::get('reportes/obtener-ingresos-empresa', 'ReporteController@empresasIngresos');
Route::get('reportes/obtener-ingresos-empresa/{start}/{end}', 'ReporteController@empresasIngresosFechas');
Route::get('reportes/egresos/{date}', 'ReporteController@egresos');
Route::get('reportes/obtener-balances', 'ReporteController@obtenerBalances');
Route::get('reportes/obtener-balances/{start}/{end}', 'ReporteController@obtenerBalancesFechas');
Route::get('reportes/obtener-tratamientos', 'ReporteController@tratamientos');
Route::get('reportes/obtener-tratamientos/{start}/{end}', 'ReporteController@tratamientosFechas');
Route::get('reportes/ganancias', 'ReporteController@ganancias');
Route::get('reportes/ganancias/{start}/{end}', 'ReporteController@gananciasFechas');
Route::get('reportes/gananciasJSON/{start}/{end}', 'ReporteController@gananciasFechasJSON');

//APIS 
Route::resource('presupuestos', 'PresupuestoController');
Route::get('presupuestos/nuevo/{idPaciente}/{idDoctor}', 'PresupuestoController@nuevo');
Route::get('presupuestos/reporte/{id}', 'PresupuestoController@reporte');

Route::resource('ingresos', 'IngresoController');
Route::get('ingresos/line-item/{id}', 'IngresoController@lineItem')->name('ingresos.lineitem');
Route::post('ingresos/line-item', 'IngresoController@lineItemSave');
Route::put('ingresos/line-item/{id}', 'IngresoController@lineItemUpdate');
Route::delete('ingresos/line-item/{id}', 'IngresoController@lineItemDelete');
Route::get('ingresos/reporte/{id}', 'IngresoController@reporte');

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