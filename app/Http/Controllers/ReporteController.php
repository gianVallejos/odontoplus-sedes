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
      $db = DB::connection(CurBD::getCurrentSchema());
      $sedes = $db->select('call OP_Sedes_get_all()');
      $sedes = json_encode(collect($sedes));
      return view('reportes.index', compact('sedes'));
    }

    public function obtenerIngresosMensuales($year, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Ingresos_get_ingresos_mensuales_anio("'. $year .'",'. $sedeId .')');
      return response()->json(['ingresos' => collect($data) ]);
    }

    public function obtenerEgresosMensuales($year, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Egresos_get_egresos_mensuales_anio("'. $year .'",'. $sedeId .')');
      return response()->json(['egresos' => collect($data) ]);
    }

    public function obtenerIngresosPacienteFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Ingresos_get_ingresos_por_paciente_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['ingresos' => collect($data) ]);
    }

    public function obtenerNuevosPacientesFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Pacientes_get_pacientes_creados_por_mes_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['nuevos_pacientes' => collect($data) ]);
    }

    public function obtenerPacientesPorCanalFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Pacientes_get_pacientes_por_canal_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['pacientes_canal' => collect($data) ]);
    }

    public function obtenerIngresosPorDoctorFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Ingresos_get_ingresos_por_doctor_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['records' => collect($data) ]);
    }

    public function obtenerPagosPorDoctorFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Pagos_get_pagos_por_doctor_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['records' => collect($data) ]);
    }

    public function obtenerTratamientosFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Tratamientos_get_tratamientos_destacados_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['tratamientos' => collect($data) ]);
    }

    public function obtenerTratamientosPorDoctorFechas($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Tratamientos_get_tratamientos_por_doctor_fechas("'. $start .'", "'. $end .'",'. $sedeId .')');
      return response()->json(['records' => collect($data) ]);
    }

    public function obtenerNuevosPacientesAnioActual(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $data = $db->select('call OP_Pacientes_get_pacientes_creados_por_mes_anio_actual()');
      return response()->json(['records' => collect($data) ]);
    }
}
