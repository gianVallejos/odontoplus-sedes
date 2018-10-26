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

    public function incomes(Request $request){
        $data = DB::select('call OP_ObtenerIngresos_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        return response()->json(['incomes' => $data ]);
    }

    public function outputs(Request $request){
        $data = DB::select('call OP_ObtenerEgresos_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        return response()->json(['outputs' => $data ]);
    }
    
    public function pacienteIncomes(Request $request){
        $data = DB::select('call OP_ObtenerIngresosPorPaciente_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        return response()->json(['incomes' => $data ]);
    }

    public function companyIncomes(Request $request){
        $data = DB::select('call OP_ObtenerIngresosPorEmpresa_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        return response()->json(['incomes' => $data ]);
    }

    public function treatments(Request $request){
        $data = DB::select('call OP_ObtenerTratamientosDestacados_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        return response()->json(['treatments' => $data ]);
    }

    public function totalIncomesOutputs(Request $request){
        $incomes = DB::select('call OP_ObtenerTotalIngresos_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        $outputs = DB::select('call OP_ObtenerTotalEgresos_Fechas(\''.$request->query('start').'\', \''.$request->query('end').'\')');
        return response()->json(['ingresos' => $incomes, 'egresos' => $outputs ]);
    }

    public function ganancias(){
        $ingresos = DB::select('call OP_ObtenerGanancias()');
        $ingresos = json_encode($ingresos);
        return view('reportes.ganancias', compact('ingresos'));    
    }

    public function reporteGanancias($fechaInicial, $fechaFinal){
        $ingresos = DB::select('call OP_ObtenerIngresos_DoctorId_RangoFechas("0","'. $fechaInicial .'","'. $fechaFinal .'")');
        $totales = DB::select('call OP_ObtenerIngresosTotales_DoctorId_RangoFechas("0","'. $fechaInicial .'","'. $fechaFinal .'")');
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['totales' => $totales[0], 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        return view('reportes.ganancias_reporte', compact('ingresos', 'igeneral'));    
    }
}