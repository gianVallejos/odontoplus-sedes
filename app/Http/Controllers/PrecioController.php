<?php

namespace App\Http\Controllers;

use App\Precio;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PrecioController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $companies =  $db->select('call OP_Empresas_get_all()');
      $companies = json_encode(collect($companies));
      $prices =  $db->select('call OP_Precios_get_all_standard()');
      $prices = json_encode(collect($prices));

      return view('precios.index',compact('companies', 'prices'));
    }

    public function getPrice(Request $request){
      $db = DB::connection(CurBD::getCurrentSchema());
      $price =  $db->select('call OP_Precios_get_by_empresa_tratamiento_Id('. $request->empresa_id .','. $request->tratamiento_id .')');
      $price = collect($price);
      return response()->json(['price' => $price ]);
    }


    public function update(Request $request, $id){
    	$validator = Validator::make($request->all(), [
            'monto' => 'required|numeric|between:0,99999999.99',
            'costo_variable' => 'required|numeric|between:0,99999999.99'
        ]);

    	if ($validator->passes()) {
        $db = DB::connection(CurBD::getCurrentSchema());
        $precio =  $db->select('call OP_Precios_update_monto_Id('. $request->monto .', '. $request->costo_variable .', '. $id .')');
        $precio = collect($precio)[0];
        if( $precio->ESTADO > 0 ){
            return response()->json(['success' => 'success']);
        }else{
            return response()->json(['error'=> 'Ha ocurrido un error']);
        }
      }
      return response()->json(['error'=>$validator->errors()]);
    }
}
