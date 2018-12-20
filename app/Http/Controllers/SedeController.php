<?php

namespace App\Http\Controllers;

use App\Sede;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class SedeController extends Controller{

    public static $validation_rules = [
        'nombre' => 'required|string|max:150',
        'direccion' => 'nullable|string|max:100'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $sedes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all');
        $sedes = json_encode($sedes);
        return view('sedes.index', compact('sedes'));
    }

    public function create(){
        return view('sedes.create');
    }

    public function show($id){
        $sede =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all_id('.$id.')')[0];
        $sede = json_encode($sede);
        return view('sedes.show', compact('sede'));
    }

    public function store(Request $request){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            $sede =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_add_all("'. $request->nombre .'", "'. $request->direccion . '")');
            if( $sede[0]->ESTADO > 0 ){
                return response()->json(['success' => 'created']);
            }
            else{
                return response()->json(['error' => 'Ha ocurrido un error al insertar la sede o sus precios']);
            }
        }

        return response()->json(['error' => $validator->errors()]);
    }

    public function update(Request $request, $id){

        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            $sede =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_update_all_Id("'. $request->nombre .'", "'. $request->direccion . '", '. $id .')');
            if( $sede[0]->ESTADO > 0 ){
                return response()->json(['success' => 'updated']);
            }else{
                return response()->json(['error' => 'Ha ocurrido un error']);
            }
        }

        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
      try{
          $canDelete =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_es_borrable_Id('. $id .')');
          if( $canDelete[0]->CAN_DELETE == '1' ){
            $sede =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_delete_all('. $id .')');
            return response()->json(['success' => 'deleted']);
          }else{
              return response()->json(['error' => 'cantDeleted']);
          }
      }catch(Exception $e){
          return response()->json(['error'=>$e->getMessage()]);
      }
    }
}
