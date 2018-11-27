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
        $tratamientos = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_get_all()');
        $tratamientos = json_encode($tratamientos);
        $pacientes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
        $pacientes = json_encode($pacientes);
        return view('tratamientos.index',compact('tratamientos', 'pacientes'));
    }

    public function create(){
        return view('tratamientos.new');
    }

    public function show($id){
        $tratamiento = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamiento_get_all_id('.$id.')')[0];
        $tratamiento = json_encode($tratamiento);
        return view('tratamientos.show', compact('tratamiento'));
    }

    public function edit($id){
        $tratamiento = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamiento_get_all_id('.$id.')')[0];
        $tratamiento = json_encode($tratamiento);
        return view('tratamientos.edit', compact('tratamiento'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'detalle' => 'required|max:120',
            'precio_estandar' => 'required|numeric|between:0,99999999.99'
        ]);

    	if ($validator->passes()) {
            try{
                DB::beginTransaction();
                $tratamiento = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_add_all("'.$request->detalle.'")');

                if ( $tratamiento[0]->ESTADO > 0 && $tratamiento[0]->LAST_ID != 0) {
                  $pricesInserted = self::insertCompaniesStandardPrices($tratamiento[0]->LAST_ID, $request->precio_estandar);
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

    public function insertCompaniesStandardPrices($treatmentId, $price){
        $companies = DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_get_all()');

        foreach ($companies as $company) {
            $precio = DB::connection(CurBD::getCurrentSchema())->select('call OP_Precios_add_all('.$company->id.','.$treatmentId.','.$price.')');
            if($precio[0]->ESTADO == 0) return false;
        }
        return true;
    }

    public function update(Request $request, $id){

    	$validator = Validator::make($request->all(), [
            'detalle' => 'required|max:120'
        ]);

    	if ($validator->passes()) {
        $tratamiento = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamientos_update_all_id('.$id.',"'.$request->detalle.'")');
        if ( $tratamiento[0]->ESTADO > 0) {
          return response()->json(['success' => 'updated']);
        }else{
          return response()->json(['error'=>$e->getMessage()]);
        }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $canDelete = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamiento_es_borrable_id('. $id .')');

            if( $canDelete[0]->CAN_DELETE == '1' ){
                $res = DB::connection(CurBD::getCurrentSchema())->select('call OP_Tratamiento_delete_Id('. $id .')');

                return response()->json(['success' => 'deleted']);
            }else{
                return response()->json(['error' => 'cantDeleted']);
            }

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
