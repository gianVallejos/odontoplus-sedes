<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class reporteController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        return view('reportes.index');
    }

    public function ingresos($date){
        $data = DB::select('call OP_ObtenerIngresos_Fechas("'. $date .'")');
        return response()->json(['ingresos' => $data ]);
    }

    public function egresos($date){
        $data = DB::select('call OP_ObtenerEgresos_Fechas("'. $date . '")');
        return response()->json(['egresos' => $data ]);
    }

    public function obtenerIngresosPaciente(){
        $data = DB::select('call OP_ObtenerIngresosPorPaciente_Reportes()');
        return response()->json(['ingresos' => $data ]);
    }

    public function obtenerIngresosPacienteFechas($start, $end){
        $data = DB::select('call OP_ObtenerIngresosPorPaciente_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['ingresos' => $data ]);
    }

    public function empresasIngresos(){
        $data = DB::select('call OP_ObtenerIngresosPorEmpresa_Reportes()');
        return response()->json(['ingresos' => $data ]);
    }

    public function empresasIngresosFechas($start, $end){
        $data = DB::select('call OP_ObtenerIngresosPorEmpresa_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['ingresos' => $data ]);
    }

    public function tratamientos(){
        $data = DB::select('call OP_ObtenerTratamientosDestacados_Reportes()');
        return response()->json(['tratamientos' => $data ]);
    }

    public function tratamientosFechas($start, $end){
        $data = DB::select('call OP_ObtenerTratamientosDestacados_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['tratamientos' => $data ]);
    }

    public function obtenerBalances(){
        $ingresos = DB::select('call OP_ObtenerTotalIngresos_Reportes()');
        $egresos = DB::select('call OP_ObtenerTotalEgresos_Reportes()');
        return response()->json(['ingresos' => $ingresos, 'egresos' => $egresos ]);
    }

    public function obtenerBalancesFechas($start, $end){
        $ingresos = DB::select('call OP_ObtenerTotalIngresos_Fechas("'. $start .'", "'. $end .'")');
        $egresos = DB::select('call OP_ObtenerTotalEgresos_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['ingresos' => $ingresos, 'egresos' => $egresos ]);
    }

    public function ingresosPorDoctor(){
        $ingresos = DB::select('call OP_ObtenerIngresosPorDoctor()');
        return response()->json(['ingresos' => $ingresos ]);
    }

    public function ingresosPorDoctorFechas($start, $end){
        $ingresos = DB::select('call OP_ObtenerIngresosPorDoctor_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['ingresos' => $ingresos ]);
    }

    public function ganancias(){
        return view('reportes.ganancias');
    }

    // gananciasFechas se usa en ganancias reporte como PDF
    public function gananciasFechas($start, $end){
        $ingresos = DB::select('call OP_ObtenerIngresos_DoctorId_RangoFechas("0","'. $start .'","'. $end .'")');
        $totales = DB::select('call OP_ObtenerIngresosTotales_DoctorId_RangoFechas("0","'. $start .'","'. $end .'")');
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['totales' => $totales[0], 'fechaInicial' => $start, 'fechaFinal' => $end]);        
        return view('reportes.ganancias_reporte', compact('ingresos', 'igeneral'));
    }

    public function gananciasFechasJSON($start, $end){
        $ingresos = DB::select('call OP_ObtenerIngresos_DoctorId_RangoFechas("0","'. $start .'","'. $end .'")');
        $ingresos = json_encode($ingresos);
        return response()->json(['ingresos' => $ingresos]);
    }
}
