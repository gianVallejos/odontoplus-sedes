<?php

namespace App\Http\Controllers;

use App\Pago;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PagoController extends Controller{

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $pagos =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_all()');
        $pagos = json_encode($pagos);
        return view('pagos.index', compact('pagos'));
    }

    public function show($pagoId,$idDoctor, $fechaInicial, $fechaFinal){
        $ingresos =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'",'.$pagoId.')');
        $totales =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_totales_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'",'.$pagoId.')');
        $doctor =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all_Id('. $idDoctor .')')[0];
        $last_pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_ultimo()')[0];
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['ultimoPago' => $last_pago, 'doctor'=> $doctor, 'totales' => $totales[0], 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        $cliente = CurBD::getCurrentClienteData();
        return view('pagos.show', compact('ingresos', 'igeneral', 'cliente'));
    }

    public function create(){
        $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);
        return view('pagos.create', compact('doctores'));
    }

    public function nuevoPagoReporte($idDoctor, $fechaInicial, $fechaFinal){
        $ingresos =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'",0)');
        $totales =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_totales_by_doctor_fechas("'. $idDoctor .'","'. $fechaInicial .'","'. $fechaFinal .'",0)');
        $doctor =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all_Id('.$idDoctor.')')[0];
        $last_pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_ultimo()')[0];
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['ultimoPago' => $last_pago, 'doctor'=> $doctor, 'totales' => $totales[0], 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        $cliente = CurBD::getCurrentClienteData();

        return view('pagos.new', compact('ingresos', 'igeneral', 'cliente'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'idDoctor' => 'required',
            'fecha_inicio' => 'required|date',
            'fecha_fin' => 'required|date'
        ]);
    	if ($validator->passes()) {
          $pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_add_all('. $request->idDoctor .', "'. $request->fecha_inicio . '", "' . $request->fecha_fin .'")');
          if( $pago[0]->ESTADO > 0 ){
              $pago_last = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_pago_last()');
              $ingresos_detalle =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_doctor_fechas("'. $request->idDoctor .'","'. $request->fecha_inicio .'","'. $request->fecha_fin .'",0)');        
              $this->ingresosDetalleUpdatePagoId($ingresos_detalle,$pago_last[0]->id);
              return response()->json(['success' => 'created']);
            }else{
                return response()->json(['error'=> 'Ha ocurrido un error']);
            }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function ingresosDetalleUpdatePagoId($ingresos_detalle,$pagoId){
        foreach( $ingresos_detalle as $ingreso_detalle ){
            $ingreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_detalle_update_pagoId('.$pagoId.','.$ingreso_detalle->id.')');
        }
        
    }

    public function destroy($id){
        $pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_delete_all('. $id .')');
        if( $pago[0]->ESTADO > 0 ){      
            $ingresos_detalle =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_pago_id('.$id.')');
            $this->ingresosDetalleUpdatePagoId($ingresos_detalle,0);
            return response()->json(['success' => 'deleted']);
        }else{
            return response()->json(['error'=> 'Ha ocurrido un error']);
        }
    }
}
