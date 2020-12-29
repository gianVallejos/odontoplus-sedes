<?php

namespace App\Http\Controllers;

use App\Tratamiento;
use App\CustomLibs\CurBD;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class TratamientoController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $tratamientos = $db->select('call OP_Tratamientos_get_all()');
      $tratamientos = json_encode(collect($tratamientos));
      $pacientes = $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode(collect($pacientes));
      return view('tratamientos.index',compact('tratamientos', 'pacientes'));
    }

    public function create(){
        return view('tratamientos.new');
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $tratamiento = $db->select('call OP_Tratamiento_get_all_id('.$id.')');
      $tratamiento = collect($tratamiento)[0];
      $tratamiento = json_encode($tratamiento);
      return view('tratamientos.show', compact('tratamiento'));
    }

    public function edit($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $tratamiento = $db->select('call OP_Tratamiento_get_all_id('.$id.')');
      $tratamiento = collect($tratamiento)[0];
      $tratamiento = json_encode($tratamiento);
      return view('tratamientos.edit', compact('tratamiento'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'detalle' => 'required|string|max:120',
            'precio_estandar' => 'required|numeric|between:0,99999999.99',
            'costo_variable' => 'required|numeric|max:'. ($request->precio_estandar) .'|between:0,99999999.99'
        ]);

    	if ($validator->passes()) {
            try{
                DB::beginTransaction();
                $db = DB::connection(CurBD::getCurrentSchema());
                $tratamiento = $db->select('call OP_Tratamientos_add_all("'.$request->detalle.'")');
                $tratamiento = collect($tratamiento)[0];

                if ( $tratamiento->ESTADO > 0 && $tratamiento->LAST_ID != 0) {
                  $pricesInserted = self::insertCompaniesStandardPrices($tratamiento->LAST_ID, $request->precio_estandar, $request->costo_variable);
                }

                if($pricesInserted){
                    DB::commit();
                    return response()->json(['success' => 'created']);
                }else{
                    DB::rollback();
                    return response()->json(['error' => 'commitFailed']);
                }
            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function insertCompaniesStandardPrices($treatmentId, $price, $costo_variable){
      $db = DB::connection(CurBD::getCurrentSchema());
      $companies = $db->select('call OP_Empresas_get_all()');
      $companies = collect($companies);
      foreach ($companies as $company) {
        $precio = $db->select('call OP_Precios_add_all('.$company->id.','.$treatmentId.','.$price.', '. $costo_variable .')');
        $precio = collect($precio)[0];
        if($precio->ESTADO == 0) return false;
      }
      return true;
    }

    public function update(Request $request, $id){
    	$validator = Validator::make($request->all(), [
            'detalle' => 'required|max:120'
        ]);

    	if ($validator->passes()) {
        $db = DB::connection(CurBD::getCurrentSchema());
        $tratamiento = $db->select('call OP_Tratamientos_update_all_id('.$id.',"'.$request->detalle.'")');
        $tratamiento = collect($tratamiento)[0];
        if ( $tratamiento->ESTADO > 0) {
          return response()->json(['success' => 'updated']);
        }else{
          return response()->json(['error'=>$e->getMessage()]);
        }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
      try{
        $db = DB::connection(CurBD::getCurrentSchema());
        $canDelete = $db->select('call OP_Tratamiento_es_borrable_id('. $id .')');
        $canDelete = collect($canDelete)[0];
        if( $canDelete->CAN_DELETE == '1' ){
          $res = $db->statement('call OP_Tratamiento_delete_Id('. $id .')');
          return response()->json(['success' => 'deleted']);
        }else{
          return response()->json(['error' => 'cantDeleted']);
        }
      }catch(Exception $e){
        return response()->json(['error'=>$e->getMessage()]);
      }
    }
}
