<?php

namespace App\Http\Controllers;

use App\Egreso;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Validator;

class EgresoController extends Controller{
    public static $validation_rules = [
        'fecha' => 'required|date',
        'tipo' => 'required',
        'doctor' => 'required_if:tipo,Pago a Personal',
        'sede' => 'required',
        'cantidad' => 'required|integer|min:0',
        'concepto' => 'required|string|max:125',
        'monto' => 'required|numeric|min:0',
        'total' => 'numeric',
    ];

    private $path = 'egresos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $egresos =  $db->select('call OP_Egresos_get_all()');
      $egresos = json_encode(collect($egresos));

      return view($this->path . '.index', compact('egresos'));
    }

    public function create(){
      $db = DB::connection(CurBD::getCurrentSchema());
        $doctores =  $db->select('call OP_Doctors_get_all()');
        $doctores = json_encode(collect($doctores));
        $sedes =  $db->select('call OP_Sedes_get_all()');
        $sedes = json_encode(collect($sedes));

        return view($this->path . '.create', compact('doctores', 'sedes'));
    }

    public function store(Request $request){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
          $db = DB::connection(CurBD::getCurrentSchema());
            if( $request->doctor == null ){
                $egreso =  $db->select('call OP_Egresos_add_all("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->sede. ')');
            }else{
                $egreso =  $db->select('call OP_Egresos_add_all_doctor("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                       . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->sede .', '. $request->doctor .')');
            }
            $egreso = collect($egreso)[0];
            if( $egreso->ESTADO > 0 ){
                return response()->json(['success' => 'created']);
            }else{
                return response()->json(['error'=> 'Ha ocurrido un error']);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $egreso =  $db->select('call OP_Egresos_get_all_Id('.$id.')')[0];
      $egreso = json_encode(collect($egreso));
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode(collect($doctores));
      $sedes =  $db->select('call OP_Sedes_get_all()');
      $sedes = json_encode(collect($sedes));

      return view('egresos.show', compact('egreso', 'doctores', 'sedes'));
    }

    public function edit($id){
      $db = DB::connection(CurBD::getCurrentSchema());
        $doctores =  $db->select('call OP_Doctors_get_all()');
        $doctores = json_encode(collect($doctores));
        $egreso =  $db->select('call OP_Egresos_get_all_Id('. $id .')')[0];
        $egreso = json_encode(collect($egreso));
        $sedes =  $db->select('call OP_Sedes_get_all()');
        $sedes = json_encode(collect($sedes));

        return view($this->path . '.edit', compact('doctores', 'egreso', 'sedes'));
    }

    public function update(Request $request, $id){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
          $db = DB::connection(CurBD::getCurrentSchema());
          if( $request->doctor == null ){
              $egreso =  $db->select('call OP_Egresos_update_all_Id("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                    . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->sede .', '. $id .')');
          }else{
              $egreso =  $db->select('call OP_Egresos_update_all_doctor_Id("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                           . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->doctor .', '. $request->sede .', '. $id .')');
          }
          $egreso = collect($egreso)[0];
          if( $egreso->ESTADO > 0 ){
              return response()->json(['success' => 'updated']);
          }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
          }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
          $db = DB::connection(CurBD::getCurrentSchema());
          $res =  $db->statement('call OP_Egresos_delete_all_Id('. $id .')');
          return response()->json(['success' => 'deleted']);
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
