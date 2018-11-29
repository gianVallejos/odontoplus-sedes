<?php

namespace App\Http\Controllers;

use App\ProveedorsDetalle;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ProveedorLineItemController extends Controller{

    public static $validation_rules = [
        'detalle' => 'required',
        'monto' => 'required',
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function show($id){
        $proveedor =  DB::connection(CurBD::getCurrentSchema())->select('call OP_ObtenerProveedores_Id('.$id.')')[0];
        $line_items =  DB::connection(CurBD::getCurrentSchema())->select('call OP_ObtenerProveedoresDetalles_Id('.$id.')');
        $data = json_encode(['proveedor' => $proveedor, 'line_items' => $line_items]);
        return view('proveedores.line_items', compact('data'));
    }
    public function store(Request $request){

    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $line_item = new ProveedorsDetalle();
                $line_item->idProveedor = $request->idProveedor;
                $line_item->detalle = $request->detalle;
                $line_item->monto = $request->monto;
                $line_item->save();

                return response()->json(['success' => 'success', 'record' => $line_item]);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function update(Request $request, $id){

    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $line_item = ProveedorsDetalle::findOrFail($id);
                $line_item->detalle = $request->detalle;
                $line_item->monto = $request->monto;
                $line_item->save();

                return response()->json(['success' => 'success', 'record' => $line_item]);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy($id){
        try{
            $proveedor = ProveedorsDetalle::findOrFail($id);
            $proveedor->delete();

            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
