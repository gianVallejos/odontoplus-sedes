<?php

namespace App\Http\Controllers;
use App\CustomLibs\CurBD;
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
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_mensuales_anio("'. $year .'")');
        return response()->json(['ingresos' => $data ]);
    }

    public function obtenerEgresosMensuales($year){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_get_egresos_mensuales_anio("'. $year . '")');
        return response()->json(['egresos' => $data ]);
    }

    public function obtenerIngresosPacienteFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_por_paciente_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['ingresos' => $data ]);
    }

    public function obtenerNuevosPacientesFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_pacientes_creados_por_mes_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['nuevos_pacientes' => $data ]);
    }

    public function obtenerPacientesPorCanalFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_pacientes_por_canal_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['pacientes_canal' => $data ]);
    }

    public function obtenerIngresosPorDoctorFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_por_doctor_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['records' => $data ]);
    }

    public function obtenerPagosPorDoctorFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_pagos_por_doctor_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['records' => $data ]);
    }

    public function obtenerTratamientosFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_get_tratamientos_destacados_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['tratamientos' => $data ]);
    }

    public function obtenerTratamientosPorDoctorFechas($start, $end){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_get_tratamientos_por_doctor_fechas("'. $start .'", "'. $end .'")');
        return response()->json(['records' => $data ]);
    }

    public function obtenerNuevosPacientesAnioActual(){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_pacientes_creados_por_mes_anio_actual()');
        return response()->json(['records' => $data ]);
    }

    // ------------------------ ganancias------------------------
    public function ganancias(){
        return view('reportes.ganancias');
    }
    // gananciasFechas se usa en ganancias reporte como PDF
    public function gananciasFechas($start, $end){
        $ingresos = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_por_doctor_doctor_id_fechas("0","'. $start .'","'. $end .'")');
        $totales = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_totales_doctor_id_fechas("0","'. $start .'","'. $end .'")');
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['totales' => $totales[0], 'fechaInicial' => $start, 'fechaFinal' => $end]);
        return view('reportes.ganancias_reporte', compact('ingresos', 'igeneral'));
    }
    public function gananciasFechasJSON($start, $end){
        $ingresos = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_por_doctor_doctor_id_fechas("0","'. $start .'","'. $end .'")');
        $ingresos = json_encode($ingresos);
        return response()->json(['ingresos' => $ingresos]);
    }
}
