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
        $pagos = DB::select('call OP_Pagos_get_all()');
        $pagos = json_encode($pagos);
        return view('pagos.index', compact('pagos'));
    }

    public function show($idDoctor, $fechaInicial, $fechaFinal){
        $ingresos = DB::select('call OP_Ingresos_get_all_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'")');
        $totales = DB::select('call OP_Ingresos_get_totales_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'")');
        $doctor = DB::select('call OP_Doctors_get_all_Id('. $idDoctor .')')[0];
        $last_pago = DB::select('call OP_Pagos_get_ultimo()')[0];
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['ultimoPago' => $last_pago, 'doctor'=> $doctor, 'totales' => $totales[0], 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        return view('pagos.show', compact('ingresos', 'igeneral'));
    }

    public function create(){
        $doctores = DB::select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);
        return view('pagos.create', compact('doctores'));
    }

    public function nuevoPagoReporte($idDoctor, $fechaInicial, $fechaFinal){
        $ingresos = DB::select('call OP_Ingresos_get_all_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'")');
        $totales = DB::select('call OP_Ingresos_get_totales_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'")');
        $doctor = DB::select('call OP_Doctors_get_all_Id('.$idDoctor.')')[0];
        $last_pago = DB::select('call OP_Pagos_get_ultimo()')[0];
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['ultimoPago' => $last_pago, 'doctor'=> $doctor, 'totales' => $totales[0], 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        return view('pagos.new', compact('ingresos', 'igeneral'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'idDoctor' => 'required',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date'
      ]);
    	if ($validator->passes()) {
          $pago = DB::select('call OP_Pagos_add_all('. $request->idDoctor .', "'. $request->fecha_inicio . '", "' . $request->fecha_fin .'")');
          if( $pago[0]->ESTADO > 0 ){
              return response()->json(['success' => 'created']);
          }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
          }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy($id){
        $pago = DB::select('call OP_Pagos_delete_all('. $id .')');
        if( $pago[0]->ESTADO > 0 ){
            return response()->json(['success' => 'deleted']);
        }else{
            return response()->json(['error'=> 'Ha ocurrido un error']);
        }
    }
}
