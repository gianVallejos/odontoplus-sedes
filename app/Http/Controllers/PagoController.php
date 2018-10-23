<?php

namespace App\Http\Controllers;

use App\Pago;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PagoController extends Controller{

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $pagos = DB::select('call OP_ObtenerPagos()'); 
        $pagos = json_encode($pagos);
        return view('pagos.index', compact('pagos'));
    }

    public function nuevoPago($idDoctor, $fechaInicial, $fechaFinal){
        $ingresos = DB::select('call OP_ObtenerIngresos_DoctorId_RangoFechas()');
        $ingresos = json_encode($ingresos);
        return view('pagos.new', compact('ingresos'));    
    }

    public function create(){
        $doctores = DB::select('call OP_ObtenerDoctores_DESC()'); 
        $doctores = json_encode($doctores);
        return view('pagos.create', compact('doctores'));    
    }
}
