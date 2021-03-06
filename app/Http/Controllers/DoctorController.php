<?php

namespace App\Http\Controllers;

use App\Doctor;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DoctorController extends Controller{

    public static $validation_rules = [
        'nombres' => 'required|string|max:90',
        'apellidos' => 'required|string|max:90',
        'dni' => 'required|digits:8',
        'email' => 'nullable|email|max:90',
        'direccion' => 'required|string|max:90',
        'fechanacimiento' => 'required|date',
        'genero' => 'nullable|string|max:25',
        'estado' => 'nullable|string|max:25',
        'telefono' => 'nullable|string|max:50',
        'celular' => 'nullable|string|max:50',
        'celular_aux' => 'nullable|string|max:50',
        'margen_ganancia' => 'nullable|integer|min:0|max:100'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $doctors = $db->select('call OP_Doctors_get_all_DESC()');
      $doctors = json_encode(collect($doctors));
      return view('doctors.index',compact('doctors'));
    }

    public function create(){
        return view('doctors.create');
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $doctor = $db->select('call OP_Doctors_get_all_Id('.$id.')')[0];
      $doctor = json_encode(collect($doctor));
      return view('doctors.show', compact('doctor'));
    }

    public function edit($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $doctor = $db->select('call OP_Doctors_get_all_Id('.$id.')')[0];
      $doctor = json_encode(collect($doctor));
      return view('doctors.edit', compact('doctor'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), self::$validation_rules );
    	if ($validator->passes()) {
          if( $request->margen_ganancia == null ){
              $request->margen_ganancia = 0;
          }
          $db = DB::connection(CurBD::getCurrentSchema());
          $doctor = $db->select('call OP_Doctors_add_all("'. $request->nombres .'", "'. $request->apellidos .'", "'. $request->dni
                                                         .'", "'. $request->email .'", "'. $request->direccion . '", "'. $request->fechanacimiento
                                                         .'", "'. $request->genero . '", "'. $request->estado .'", "'. $request->telefono
                                                         .'", "'. $request->celular . '", "'. $request->celular_aux . '", ' . $request->margen_ganancia .')');
          $doctor = collect($doctor)[0];
          if( $doctor->ESTADO > 0 ){
              return response()->json(['success' => 'created']);
          }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
          }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function update(Request $request, $id){
    	$validator = Validator::make($request->all(), self::$validation_rules );
    	if ($validator->passes()) {
          if( $request->margen_ganancia == null ){
              $request->margen_ganancia = 0;
          }
          $db = DB::connection(CurBD::getCurrentSchema());
          $doctor = $db->select('call OP_Doctors_update_all_Id("'. $request->nombres .'", "'. $request->apellidos .'", "'. $request->dni
                                                                .'", "'. $request->email .'", "'. $request->direccion . '", "'. $request->fechanacimiento
                                                                .'", "'. $request->genero . '", "'. $request->estado .'", "'. $request->telefono
                                                                .'", "'. $request->celular . '", "'. $request->celular_aux . '", ' . $request->margen_ganancia .', '. $id .')');
          $doctor = collect($doctor)[0];
          if( $doctor->ESTADO > 0 ){
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
          $canDelete = $db->select('call OP_Doctors_es_borrable_Id('. $id .')');
          $canDelete = collect($canDelete)[0];
          if( $canDelete->CAN_DELETE == '1' ){
              $res = $db->statement('call OP_Doctors_delete_all_Id('. $id .')');
              return response()->json(['success' => 'deleted']);
          }else{
              return response()->json(['error' => 'cantDeleted']);
          }
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
