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
        'ciudad' => 'required|string|max:150',
        'direccion' => 'required|string|max:100',
        'telefono' => 'nullable|string|max:200',
        'celular' => 'nullable|string|max:200',
        'celular_aux' => 'nullable|string|max:200',
        'email' => 'nullable|email|string|max:200'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $sedes =  $db->select('call OP_Sedes_get_all');
      $sedes = json_encode(collect($sedes));
      return view('sedes.index', compact('sedes'));
    }

    public function create(){
        return view('sedes.create');
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $sede =  $db->select('call OP_Sedes_get_all_id('.$id.')');
      $sede = collect($sede)[0];
      $sede = json_encode($sede);
      return view('sedes.show', compact('sede'));
    }

    public function edit($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $sede =  $db->select('call OP_Sedes_get_all_id('.$id.')');
      $sede = collect($sede)[0];
      $sede = json_encode($sede);
      return view('sedes.edit', compact('sede'));
    }

    public function store(Request $request){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
          $db = DB::connection(CurBD::getCurrentSchema());
          $sede =  $db->select('call OP_Sedes_add_all("'. $request->nombre .'", "'. $request->ciudad .'","'.
                                                                  $request->direccion .'","'. $request->telefono .'","'. $request->celular .'","'.
                                                                  $request->calular_aux .'","'. $request->email .'")');
          $sede = collect($sede)[0];
          if( $sede->ESTADO > 0 ){
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
          $db = DB::connection(CurBD::getCurrentSchema());
          $sede =  $db->select('call OP_Sedes_update_all_Id('. $id .',"'. $request->nombre .'", "'. $request->ciudad .'","'.
                                                                      $request->direccion .'","'. $request->telefono .'","'. $request->celular .'","'.
                                                                      $request->calular_aux .'","'. $request->email .'")');
          $sede = collect($sede)[0];
          if( $sede->ESTADO > 0 ){
              return response()->json(['success' => 'updated']);
          }else{
              return response()->json(['error' => 'Ha ocurrido un error']);
          }
        }

        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
      try{
        $db = DB::connection(CurBD::getCurrentSchema());
        $canDelete =  $db->select('call OP_Sedes_es_borrable_Id('. $id .')');
        $canDelete = collect($canDelete)[0];
        if( $canDelete->CAN_DELETE == '1' ){
          $sede =  $db->statement('call OP_Sedes_delete_all('. $id .')');
          return response()->json(['success' => 'deleted']);
        }else{
            return response()->json(['error' => 'cantDeleted']);
        }
      }catch(Exception $e){
          return response()->json(['error'=>$e->getMessage()]);
      }
    }
}
