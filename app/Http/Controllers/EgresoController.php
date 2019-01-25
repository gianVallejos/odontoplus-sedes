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
        $egresos =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_get_all()');
        $egresos = json_encode($egresos);

        return view($this->path . '.index', compact('egresos'));
    }

    public function create(){
        $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);
        $sedes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
        $sedes = json_encode($sedes);

        return view($this->path . '.create', compact('doctores', 'sedes'));
    }

    public function store(Request $request){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            if( $request->doctor == null ){
                $egreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_add_all("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->sede. ')');
            }else{
                $egreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_add_all_doctor("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                       . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->sede .', '. $request->doctor .')');
            }
            if( $egreso[0]->ESTADO > 0 ){
                return response()->json(['success' => 'created']);
            }else{
                return response()->json(['error'=> 'Ha ocurrido un error']);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function show($id){
        $egreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_get_all_Id('.$id.')')[0];
        $egreso = json_encode($egreso);
        $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);
        $sedes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
        $sedes = json_encode($sedes);

        return view('egresos.show', compact('egreso', 'doctores', 'sedes'));
    }

    public function edit($id){
        $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);
        $egreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_get_all_Id('. $id .')')[0];
        $egreso = json_encode($egreso);
        $sedes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
        $sedes = json_encode($sedes);

        return view($this->path . '.edit', compact('doctores', 'egreso', 'sedes'));
    }

    public function update(Request $request, $id){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
          if( $request->doctor == null ){
              $egreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_update_all_Id("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                    . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->sede .', '. $id .')');
          }else{
              $egreso =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_update_all_doctor_Id("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                           . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->doctor .', '. $request->sede .', '. $id .')');
          }
          if( $egreso[0]->ESTADO > 0 ){
              return response()->json(['success' => 'updated']);
          }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
          }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $res =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Egresos_delete_all_Id('. $id .')');
            return response()->json(['success' => 'deleted']);
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
