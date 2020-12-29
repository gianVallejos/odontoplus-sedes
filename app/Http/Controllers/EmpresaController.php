<?php

namespace App\Http\Controllers;

use App\Empresa;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class EmpresaController extends Controller{

    public static $validation_rules = [
        'nombre' => 'required|string|max:120',
        'ruc' => 'nullable|digits:11'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $empresas =  $db->select('call OP_Empresas_get_all_desc()');
      $empresas = json_encode(collect($empresas));
      return view('empresas.index', compact('empresas'));
    }

    public function create(){
      return view('empresas.create');
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $empresa =  $db->select('call OP_Empresas_get_all_Id('.$id.')');
      $empresa = collect($empresa)[0];
      $empresa = json_encode($empresa);
      return view('empresas.show', compact('empresa'));
    }

    public function edit($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $empresa =  $db->select('call OP_Empresas_get_all_Id('.$id.')');
      $empresa = collect($empresa)[0];
      $empresa = json_encode($empresa);
      return view('empresas.edit', compact('empresa'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                DB::beginTransaction();
                $db = DB::connection(CurBD::getCurrentSchema());
                $empresa =  $db->select('call OP_Empresas_add_all("'. $request->nombre .'", "'. $request->ruc . '")');
                $empresa = collect($empresa)[0];
                if( $empresa->ESTADO > 0 ){
                    $pricesInserted = self::insertTreatmentsStandardPrices($empresa->LAST_ID);
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
      $db = DB::connection(CurBD::getCurrentSchema());
      $prices =  $db->select('call OP_Precios_get_all_standard()');
      $prices = collect($prices);
      foreach ($prices as $price) {
        $status =  $db->select('call OP_Precios_add_all('.$companyId.','.$price->id_tratamiento.','.$price->monto.', '. $price->costo_variable .')');
        $status = collect($status)[0];
        if($status->ESTADO == 0) return false;
      }
      return true;
    }

    public function update(Request $request, $id){
    	$validator = Validator::make($request->all(), self::$validation_rules );
    	if ($validator->passes()) {
        $db = DB::connection(CurBD::getCurrentSchema());
        $empresa =  $db->select('call OP_Empresas_update_all_Id("'. $request->nombre .'", "'. $request->ruc . '", '. $id .')');
        $empresa = collect($empresa)[0];
        if( $empresa->ESTADO > 0 ){
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
        $canDelete =  $db->select('call OP_Empresas_es_borrable_Id('. $id .')');
        $canDelete = collect($canDelete)[0];
        if( $canDelete->CAN_DELETE == '1' ){
          $empresa =  $db->statement('call OP_Empresas_delete_all('. $id .')');
          return response()->json(['success' => 'deleted']);
        }else{
            return response()->json(['error' => 'cantDeleted']);
        }
      }catch(Exception $e){
          return response()->json(['error'=>$e->getMessage()]);
      }
    }
}
