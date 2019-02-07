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
        $sedes = null;
        if (\Auth::user()->rolid == 3) {  
            $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all_id('.CurBD::getCurrentSede().')');
        }else {
            $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
        }
        $sedes = json_encode($sedes);
        $is_admin_sede = \Auth::user()->rolid == 3 ? json_encode(true) : json_encode(false);;

        return view('reportes.index', compact('sedes','is_admin_sede'));
    }

    public function obtenerIngresosMensuales($year, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_mensuales_anio("'. $year .'",'. $sedeId .')');
        return response()->json(['ingresos' => $data ]);
    }

    public function obtenerEgresosMensuales($year, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_get_egresos_mensuales_anio("'. $year .'",'. $sedeId .')');
        return response()->json(['egresos' => $data ]);
    }

    public function obtenerIngresosPacienteFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_por_paciente_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['ingresos' => $data ]);
    }

    public function obtenerNuevosPacientesFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_pacientes_creados_por_mes_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['nuevos_pacientes' => $data ]);
    }

    public function obtenerPacientesPorCanalFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_pacientes_por_canal_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['pacientes_canal' => $data ]);
    }

    public function obtenerIngresosPorDoctorFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ingresos_por_doctor_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['records' => $data ]);
    }

    public function obtenerPagosPorDoctorFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_pagos_por_doctor_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['records' => $data ]);
    }

    public function obtenerTratamientosFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_get_tratamientos_destacados_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['tratamientos' => $data ]);
    }

    public function obtenerTratamientosPorDoctorFechas($start, $end, $sedeId){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_get_tratamientos_por_doctor_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
        return response()->json(['records' => $data ]);
    }

    public function obtenerNuevosPacientesAnioActual(){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_pacientes_creados_por_mes_anio_actual()');
        return response()->json(['records' => $data ]);
    }
}
