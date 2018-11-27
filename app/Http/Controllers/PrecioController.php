<?php

namespace App\Http\Controllers;

use App\Precio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PrecioController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $companies = DB::select('call OP_Empresas_get_all()');
        $prices = DB::select('call OP_Precios_get_all_standard()');
        $companies = json_encode($companies);
        $prices = json_encode($prices);

        return view('precios.index',compact('companies', 'prices'));
    }

    public function getPrice(Request $request){
        $price = DB::select('call OP_Precios_get_by_empresa_tratamiento_Id('. $request->empresa_id .','. $request->tratamiento_id .')');
        return response()->json(['price' => $price ]);
    }


    public function update(Request $request, $id){

    	$validator = Validator::make($request->all(), [
            'monto' => 'required|numeric|between:0,99999999.99'
        ]);

    	if ($validator->passes()) {

            try{
                $precio = Precio::findOrFail($id);
                $precio->monto = $request->monto;
                $precio->save();
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }
}
