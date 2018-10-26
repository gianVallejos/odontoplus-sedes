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
        $ingresos = DB::select('call OP_ObtenerIngresos_DoctorId_RangoFechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'")');
        $totales = DB::select('call OP_ObtenerIngresosTotales_DoctorId_RangoFechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'")');
        $doctor = DB::select('call OP_ObtenerDoctores_Id('.$idDoctor.')')[0];
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['doctor'=> $doctor, 'totales' => $totales[0], 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        return view('pagos.new', compact('ingresos', 'igeneral'));    
    }

    public function create(){
        $doctores = DB::select('call OP_ObtenerDoctores_DESC()'); 
        $doctores = json_encode($doctores);
        return view('pagos.create', compact('doctores'));    
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'idDoctor' => 'required',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date'
        ]);

    	if ($validator->passes()) {
            try{
                $user = new Pago();
                $user->idDoctor = $request->idDoctor;
                $user->fecha_inicio = $request->fecha_inicio;
                $user->fecha_fin = $request->fecha_fin;
                $user->save();
                    
                return response()->json(['success' => 'created']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }
}
