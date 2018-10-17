<?php

namespace App\Http\Controllers;

use App\Tratamiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class TratamientoController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $tratamientos = DB::select('call OP_ObtenerTratamientos()'); 
        $tratamientos = json_encode($tratamientos);
        return view('tratamientos.index',compact('tratamientos'));
    }

    public function create(){
        return view('tratamientos.new');   
    }

    public function show($id){
        $tratamiento = DB::select('call OP_ObtenerTratamientos_Id('.$id.')')[0];
        $tratamiento = json_encode($tratamiento);       
        return view('tratamientos.show', compact('tratamiento'));
    }

    public function edit($id){
        $tratamiento = DB::select('call OP_ObtenerTratamientos_Id('.$id.')')[0];
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
                $tratamiento = new tratamiento();
                $tratamiento->detalle = $request->detalle;
                $tratamiento->save();
                self::insertStandardPricesToAllCompanies($tratamiento->id, $request->precio_estandar);
                
                return response()->json(['success' => 'created']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function insertStandardPricesToAllCompanies($treatmentId, $price){
        $companies = DB::select('call OP_ObtenerEmpresas()');
        foreach ($companies as $company) {
            DB::select('call OP_AgregarPreciosPorEmpresa('.$company->id.','.$treatmentId.','.$price.')');
        }
    }

    public function update(Request $request, $id){
        
    	$validator = Validator::make($request->all(), [
            'detalle' => 'required|max:120'
        ]);

    	if ($validator->passes()) {
            try{
                $tratamiento = Tratamiento::findOrFail($id);
                $tratamiento->detalle = $request->detalle;
                $tratamiento->is_active = $request->is_active;
                $tratamiento->save();

                return response()->json(['success' => 'updated']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $canDelete = DB::select('call OP_esTratamientoBorrable_Id('. $id .')');
            
            if( $canDelete[0]->CAN_DELETE == '1' ){
                $res = DB::select('call OP_eliminarTratamiento_Id('. $id .')');

                return response()->json(['success' => 'deleted']);
            }else{
                return response()->json(['error' => 'cantDeleted']);
            }            

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
