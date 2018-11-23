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

    public function obtenerIngresosMensuales($year){
        $data = DB::select('call OP_ObtenerIngresosMensuales_Anio("'. $year .'")');
        return response()->json(['ingresos' => $data ]);
    }
    public function obtenerEgresosMensuales($year){
        $data = DB::select('call OP_ObtenerEgresosMensuales_Anio("'. $year . '")');
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

    public function obtenerNuevosPacientesFechas($start, $end){
        $data = DB::select('call OP_ObtenerNuevosPacientesPorMes_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['nuevos_pacientes' => $data ]);
    }

    public function obtenerPacientesPorCanalFechas($start, $end){
        $data = DB::select('call OP_ObtenerPacientesPorCanal_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['pacientes_canal' => $data ]);
    }

    public function obtenerIngresosPorDoctorFechas($start, $end){
        $data = DB::select('call OP_ObtenerIngresosPorDoctor_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['records' => $data ]);
    }

    public function obtenerPagosPorDoctorFechas($start, $end){
        $data = DB::select('call OP_ObtenerPagosPorDoctor_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['records' => $data ]);
    }

    public function obtenerTratamientosFechas($start, $end){
        $data = DB::select('call OP_ObtenerTratamientosDestacados_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['tratamientos' => $data ]);
    }

    public function obtenerTratamientosPorDoctorFechas($start, $end){
        $data = DB::select('call OP_ObtenerTratamientosPorDoctor_Fechas("'. $start .'", "'. $end .'")');
        return response()->json(['records' => $data ]);
    }

    public function obtenerNuevosPacientesAnioActual(){
        $data = DB::select('call OP_ObtenerNuevosPacientesPorMesAnioActual()');
        return response()->json(['records' => $data ]);
    }

    // ------------------------ ganancias------------------------
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
