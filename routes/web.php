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
Route::get('pacientes/{id}/{flag}', 'PacienteController@show');

//REPORTS
Route::get('reportes', 'ReporteController@index');
Route::get('reportes/obtener-ingresos-mensuales/{year}', 'ReporteController@obtenerIngresosMensuales');
Route::get('reportes/obtener-egresos-mensuales/{year}', 'ReporteController@obtenerEgresosMensuales');
Route::get('reportes/obtener-ingresos-paciente/{start}/{end}', 'ReporteController@obtenerIngresosPacienteFechas');
Route::get('reportes/obtener-nuevos-pacientes/{start}/{end}', 'ReporteController@obtenerNuevosPacientesFechas');
Route::get('reportes/obtener-nuevos-pacientes-anio-actual', 'ReporteController@obtenerNuevosPacientesAnioActual');
Route::get('reportes/obtener-pacientes-canal/{start}/{end}', 'ReporteController@obtenerPacientesPorCanalFechas');
Route::get('reportes/obtener-ingresos-doctor/{start}/{end}', 'ReporteController@obtenerIngresosPorDoctorFechas');
Route::get('reportes/obtener-pagos-doctor/{start}/{end}', 'ReporteController@obtenerPagosPorDoctorFechas');
Route::get('reportes/obtener-tratamientos/{start}/{end}', 'ReporteController@obtenerTratamientosFechas');
Route::get('reportes/obtener-tratamientos-doctor/{start}/{end}', 'ReporteController@obtenerTratamientosPorDoctorFechas');

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
