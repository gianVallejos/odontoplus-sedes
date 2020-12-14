<?php

namespace App\Http\Controllers;

use App\Ingreso;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Validator;

class IngresoController extends Controller
{
    public static $validation_rules = [
        'fecha' => 'required|date',
        'paciente' => 'required'
    ];

    public static $validation_line_item_rules = [
        'fecha' => 'required|date',
        'doctor' => 'required',
        'codigo' => 'nullable|string|max:120',
        'tipo_pago' => 'required|string|max:120',
    ];

    private $path = 'ingresos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $ingresos =  $db->select('call OP_Ingresos_get_all()');
      $ingresos = json_encode(collect($ingresos));

      return view($this->path . '.index', compact('ingresos'));
    }

    public function create() {
      $db = DB::connection(CurBD::getCurrentSchema());
      $pacientes =  $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode(collect($pacientes));
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode(collect($doctores));

      return view($this->path . '.create', compact('pacientes', 'doctores'));
    }

    public function store(Request $request)
    {
      //Doesn't Exists
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            try{
              $db = DB::connection(CurBD::getCurrentSchema());
              $ingreso =  $db->select('call OP_Ingresos_add_all(?)', array($request->idPaciente));
              $ingreso = collect($ingreso)[0];
              if( $ingreso->ESTADO > 0 ){
                return response()->json(['success' => 'created']);
              }else{
                return response()->json(['error' => 'Ha ocurrido un error']);
              }
            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function reporte($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $igeneral =  $db->select('call OP_Ingresos_get_all_Id(?)', array($id));
      $igeneral = collect($igeneral)[0];
      $pacienteSedeId = $igeneral->pacienteSedeId;
      $igeneral = json_encode($igeneral);
      $idetalle =  $db->select('call OP_Ingresos_Detalle_get_all_Id(?)', array($id));
      $idetalle = json_encode(collect($idetalle));
      $paciente_sede =  $db->select('call OP_Sedes_get_all_id(?)', array($pacienteSedeId));
      $paciente_sede = json_encode(collect($paciente_sede)[0]);

      return view($this->path . '.reporte', compact('igeneral', 'idetalle', 'paciente_sede'));
    }

    public function lineItem($id){
        try{
          $db = DB::connection(CurBD::getCurrentSchema());
          $ingresos =  $db->select('call OP_Ingresos_get_all_Id(?)', array($id));
          $ingresos = collect($ingresos)[0];
          $hc = $ingresos->hc;
          $ingresos = json_encode($ingresos);
          
          
          $ingreso_detalle =  $db->select('call OP_Ingresos_Detalle_get_all_Id(?)', array($id));
          $ingreso_detalle = json_encode(collect($ingreso_detalle));
                    
          $tratamientos =  $db->select('call OP_Tratamientos_get_all_pacienteId(?)', array($hc));
          $tratamientos = json_encode(collect($tratamientos));

          $doctores =  $db->select('call OP_Doctors_get_all()');
          $doctores = json_encode(collect($doctores));

          $sedes = $db->select('call OP_Sedes_get_all()');
          $sedes = json_encode(collect($sedes));

          $presupuestos_by_ingreso =  $db->select('call OP_Ingresos_get_presupuestos_Id(?)', array($id));
          $presupuestos_by_ingreso = json_encode(collect($presupuestos_by_ingreso));

          return view('ingresos.line-item', compact('ingresos', 'ingreso_detalle', 'tratamientos', 'doctores', 'sedes', 'presupuestos_by_ingreso'));
        }catch(Exception $e){
          echo 'Ha ocurrido un error'; die();
        }
    }

    public function lineItemSave(Request $request){
            try{
                $db = DB::connection(CurBD::getCurrentSchema());
                foreach( $request->trats as $trat ){
                    $ingreso =  $db->statement('call OP_Ingresos_Detalle_add_all(?,?,?,?,?,?,?,?,?,?,?)', 
                                                          array(
                                                           $request->ingresoId, $trat['precioId'], $trat['cantidad'], 
                                                           $trat['monto'], $request->igv, $trat['costo_variable'],
                                                           $request->fecha, $request->doctor, $request->codigo, 
                                                           $request->tipo_pago, $request->sede
                                                          )
                                            );                  
                }

                $last_ingreso =  $db->select('call OP_Ingresos_Detalle_get_ultimo_Id(?)', array($request->ingresoId));                
                $result = collect($last_ingreso);
                $last_ingreso = $result[0];
                
                $total_ingreso =  $db->select('call OP_Ingresos_get_monto_total_Id(?)', array($request->ingresoId));
                $result = collect($total_ingreso);
                $total_ingreso = $result[0];
                $Ingresototal = $total_ingreso->total;

                $ing_total =  $db->select('call OP_Ingresos_Detalle_get_all_total_Id(?)', array($last_ingreso->lastIngresoDetalle));
                $result = collect($ing_total);
                $ing_total = $result[0];
                $mg = $ing_total->mg;
                $mg_core = $ing_total->mg_core;

                return response()->json(['success' => 'ok', 'last_ingreso' => $last_ingreso->lastIngresoDetalle, 'total' => $Ingresototal, 'mg' => $mg, 'mg_core' => $mg_core]);

            }catch(Exception $e){
                echo 'Something went wrong';
                print_r($e);
                die();
                return response()->json(['error'=>$e->getMessage()]);
            }

        return response()->json(['error'=>$validator->errors()]);
    }

    public function lineItemUpdate(Request $request, $id){        
      try{
          $db = DB::connection(CurBD::getCurrentSchema());
          foreach( $request->trats as $trat ){
              $ingreso =  $db->statement('call OP_Ingresos_Detalle_update_all(?,?,?,?,?,?,?,?,?,?,?)',
                                          array (
                                            $request->ingresoId, $trat['precioId'], 
                                            $trat['cantidad'], $trat['monto'], $request->igv, 
                                            $request->fecha, $request->doctor, 
                                            $request->codigo, $request->tipo_pago, $request->sede, $id
                                          )
                                        );
          }

          $total_ingreso =  $db->select('call OP_Ingresos_get_monto_total_Id(?)', array($request->ingresoId));
          $result = collect($total_ingreso);
          $total_ingreso = $result[0];
          $Ingresototal = $total_ingreso->total;

          $ing_total =  $db->select('call OP_Ingresos_Detalle_get_all_total_Id(?)', array($id));
          $result = collect($ing_total);
          $ing_total = $result[0];
          $mg = $ing_total->mg;
          $mg_core = $ing_total->mg_core;

          return response()->json(['success' => 'ok', 'total' => $Ingresototal, 'mg' => $mg, 'mg_core' => $mg_core]);

      }catch(Exception $e){
          return response()->json(['error'=>$e->getMessage()]);
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function lineItemDelete($id){
        try{
          $db = DB::connection(CurBD::getCurrentSchema());
          $ingreso =  $db->statement('call OP_Ingresos_Detalle_delete_all(?)', array($id));
          return response()->json(['success' => 'ok']);
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $ingreso =  $db->select('call OP_Ingresos_get_all_Id(?)', array($id));
      $ingreso = json_encode(collect($ingreso)[0]);
      $pacientes =  $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode(collect($pacientes));
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode(collect($doctores));

      return view('ingresos.show', compact('ingreso', 'pacientes', 'doctores'));
    }

    public function edit($id)
    {
      //Doesn't exist
      $db = DB::connection(CurBD::getCurrentSchema());
      $pacientes =  $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode($pacientes);
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode($doctores);
      $ingreso =  $db->select('call OP_Ingresos_get_all_Id('. $id .')')[0];
      $ingreso = json_encode($ingreso);

      return view($this->path . '.edit', compact('pacientes', 'doctores', 'ingreso'));
    }

    public function update(Request $request, $id){
      //Doesn't exist
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            try{
                $ingreso = Ingreso::findOrFail($id);
                $ingreso->idPaciente = $request->idPaciente;
                $ingreso->fecha = $request->fecha;
                $ingreso->save();

                return response()->json(['success' => 'updated']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
    //Desn't Exist
        try{
          $db = DB::connection(CurBD::getCurrentSchema());
          $canDelete =  $db->select('call OP_Ingresos_es_borrable_id('. $id .')');
          if( $canDelete[0]->CAN_DELETE == '1' ){
              $ingreso = Ingreso::findOrFail($id);
              $ingreso->is_deleted = true;
              $ingreso->save();

              return response()->json(['success' => 'deleted']);
          }else{
              return response()->json(['error' => 'cantDeleted']);
          }
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
