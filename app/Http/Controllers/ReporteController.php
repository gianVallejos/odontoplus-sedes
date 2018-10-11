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
}