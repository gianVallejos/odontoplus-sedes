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
        $pagos = json_encode(collect($pagos));
        return view('pagos.index', compact('pagos'));
    }

    public function show($pagoId,$idDoctor, $fechaInicial, $fechaFinal){
        $ingresos =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_doctor_fechas(?,?,?,?)', 
                                                                        array($idDoctor, $fechaInicial, $fechaFinal, $pagoId));
        $totales =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_totales_by_doctor_fechas(?,?,?,?)',
                                                                        array($idDoctor, $fechaInicial, $fechaFinal, $pagoId));
        $totales = collect($totales)[0];
        $doctor =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all_Id(?)', array($idDoctor));
        $doctor = collect($doctor)[0];
        $last_pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_ultimo()');
        $last_pago = collect($last_pago)[0];
        $ingresos = json_encode(collect($ingresos));
        $igeneral = json_encode(['ultimoPago' => $last_pago, 'doctor'=> $doctor, 'totales' => $totales, 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
        $cliente = CurBD::getCurrentClienteData();
        return view('pagos.show', compact('ingresos', 'igeneral', 'cliente'));
    }

    public function create(){
        $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
        $doctores = json_encode(collect($doctores));
        return view('pagos.create', compact('doctores'));
    }

    public function nuevoPagoReporte($idDoctor, $fechaInicial, $fechaFinal){
        $ingresos =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_doctor_fechas(?,?,?,?)',
                                                                        array($idDoctor, $fechaInicial, $fechaFinal, 0));
        $totales =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_totales_by_doctor_fechas(?,?,?,?)',
                                                                       array($idDoctor, $fechaInicial, $fechaFinal, 0));
        $totales = collect($totales)[0];
        $doctor =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all_Id(?)', array($idDoctor));
        $doctor = collect($doctor)[0];
        $last_pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_ultimo()');
        $last_pago = collect($last_pago)[0];
        $ingresos = json_encode(collect($ingresos));
        $igeneral = json_encode(['ultimoPago' => $last_pago, 'doctor'=> $doctor, 'totales' => $totales, 'fechaInicial' => $fechaInicial, 'fechaFinal' => $fechaFinal]);
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
          $pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_add_all(?,?,?)',
                                                                      array($request->idDoctor, $request->fecha_inicio, $request->fecha_fin));
          $pago = collect($pago);
          if( $pago[0]->ESTADO > 0 ){
              $pago_last = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_get_pago_last()');
              $pago_last = collect($pago_last);
              $ingresos_detalle =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_doctor_fechas(?,?,?,?)',
                                                                                      array($request->idDoctor, $request->fecha_inicio, $request->fecha_fin, 0));        
              $ingresos_detalle = collect($ingresos_detalle);
              $this->ingresosDetalleUpdatePagoId($ingresos_detalle,$pago_last[0]->id);
              return response()->json(['success' => 'created']);
            }else{
                return response()->json(['error'=> 'Ha ocurrido un error']);
            }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function ingresosDetalleUpdatePagoId($ingresos_detalle,$pagoId){
      echo '!' . $ingresos_detalle . ' - ' . $pagoId; 
      foreach( $ingresos_detalle as $ingreso_detalle ){
        echo '!!' . $ingreso_detalle->id;
        $ingreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_detalle_update_pagoId(?,?)', array($pagoId, $ingreso_detalle->id));
        $ingreso = collect($ingreso);
      }        
    }

    public function destroy($id){
        $pago =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pagos_delete_all(?)', array($id));
        $pago = collect($pago);
        if( $pago[0]->ESTADO > 0 ){      
            $ingresos_detalle =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_all_by_pago_id(?)', array($id));
            $ingresos_detalle = collect($ingresos_detalle);
            $this->ingresosDetalleUpdatePagoId($ingresos_detalle,0);
            return response()->json(['success' => 'deleted']);
        }else{
            return response()->json(['error'=> 'Ha ocurrido un error']);
        }
    }
}
