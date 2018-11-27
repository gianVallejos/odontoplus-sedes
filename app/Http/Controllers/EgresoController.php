<?php

namespace App\Http\Controllers;

use App\Egreso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Validator;

class EgresoController extends Controller{
    public static $validation_rules = [
        'fecha' => 'required|date',
        'tipo' => 'required',
        'doctor' => 'required_if:tipo,Pago a Personal',
        'cantidad' => 'required|numeric',
        'concepto' => 'required|string|max:125',
        'monto' => 'required|numeric',
        'total' => 'numeric',
    ];

    private $path = 'egresos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $egresos = DB::select('call OP_Egresos_get_all()');
        $egresos = json_encode($egresos);

        return view($this->path . '.index', compact('egresos'));
    }

    public function create(){
        $doctores = DB::select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);

        return view($this->path . '.create', compact('doctores'));
    }

    public function store(Request $request){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            if( $request->doctor == null ){
                $egreso = DB::select('call OP_Egresos_add_all("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                . $request->tipo . '", "'. $request->nota .'", '. $request->monto .')');
            }else{
                $egreso = DB::select('call OP_Egresos_add_all_doctor("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                       . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->doctor .')');
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
        $egreso = DB::select('call OP_Egresos_get_all_Id('.$id.')')[0];
        $egreso = json_encode($egreso);
        $doctores = DB::select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);

        return view('egresos.show', compact('egreso', 'doctores'));
    }

    public function edit($id){
        $doctores = DB::select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);
        $egreso = DB::select('call OP_Egresos_get_all_Id('. $id .')')[0];
        $egreso = json_encode($egreso);

        return view($this->path . '.edit', compact('doctores', 'egreso'));
    }

    public function update(Request $request, $id){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
          if( $request->doctor == null ){
              $egreso = DB::select('call OP_Egresos_update_all_Id("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                    . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $id .')');
          }else{
              $egreso = DB::select('call OP_Egresos_update_all_doctor_Id("'. $request->fecha .'", '. $request->cantidad . ', "' . $request->concepto .'", "'
                                                                           . $request->tipo . '", "'. $request->nota .'", '. $request->monto .', '. $request->doctor .', '. $id .')');
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
            $res = DB::select('call OP_Egresos_delete_all_Id('. $id .')');
            return response()->json(['success' => 'deleted']);
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
