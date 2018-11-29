<?php

namespace App\Http\Controllers;

use App\Empresa;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class EmpresaController extends Controller{

    public static $validation_rules = [
        'nombre' => 'required|max:120',
        'ruc' => 'nullable|digits:12'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $empresas =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_get_all_desc()');
        $empresas = json_encode($empresas);
        return view('empresas.index', compact('empresas'));
    }

    public function create(){
        return view('empresas.create');
    }

    public function show($id){
        $empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_get_all_Id('.$id.')')[0];
        $empresa = json_encode($empresa);
        return view('empresas.show', compact('empresa'));
    }

    public function edit($id){
        $empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_get_all_Id('.$id.')')[0];
        $empresa = json_encode($empresa);
        return view('empresas.edit', compact('empresa'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                DB::beginTransaction();
                $empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_add_all("'. $request->nombre .'", "'. $request->ruc . '")');
                if( $empresa[0]->ESTADO > 0 ){
                    $pricesInserted = self::insertTreatmentsStandardPrices($empresa[0]->LAST_ID);
                    if($pricesInserted){
                        DB::commit();
                        $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Empresa registrada correctamente']));
                        return response()->json(['success' => 'created']);
                    }else{
                        DB::rollback();
                        return response()->json(['error' => 'Ha ocurrido un error al insertar la empresa o sus precios']);
                    }
                }
            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }

        return response()->json(['error' => $validator->errors()]);
    }

    public function insertTreatmentsStandardPrices($companyId){
        $prices =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Precios_get_all_standard()');

        foreach ($prices as $price) {
            $status =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Precios_add_all('.$companyId.','.$price->id_tratamiento.','.$price->monto.')');
            if($status[0]->ESTADO == 0) return false;
        }
        return true;
    }

    public function update(Request $request, $id){

    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            $empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_update_all_Id("'. $request->nombre .'", "'. $request->ruc . '", '. $id .')');
            if( $empresa[0]->ESTADO > 0 ){
                return response()->json(['success' => 'updated']);
            }else{
                return response()->json(['error' => 'Ha ocurrido un error']);
            }
        }

        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
      try{
        //FALTA VERIFICAR SI ES BORRABLE
          $empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Empresas_delete_all('. $id .')');
          return response()->json(['success' => 'deleted']);
      }catch(Exception $e){
          return response()->json(['error' => 'Ha ocurrido un error']);
      }
    }
}
