<?php

namespace App\Http\Controllers;

use App\Tratamiento;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class TratamientoController extends Controller{
    public static $validation_rules = [
        'detalle' => 'required|max:120',
        'precio_estandar' => 'required|min:0'
    ];

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
        
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                DB::beginTransaction();

                $tratamiento = new tratamiento();
                $tratamiento->detalle = $request->detalle;
                $tratamiento->save();
                $pricesInserted = self::insertCompaniesStandardPrices($tratamiento->id, $request->precio_estandar);
                
                if($pricesInserted){
                    DB::commit();
                    $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Tratamiento registrado correctamente']));
                    return response()->json(['success' => 'success']);
                }
                else{
                    DB::rollback();
                    return response()->json(['error' => 'Ha ocurrido un error al insertar el tratamiento o sus precios']);
                }
            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function insertCompaniesStandardPrices($treatmentId, $price){
        $companies = DB::select('call OP_ObtenerEmpresas()');
         
        foreach ($companies as $company) {
            $status = DB::select('call OP_AgregarPrecios_EmpresaId_TratamientoId('.$company->id.','.$treatmentId.','.$price.')');
            if($status == 0) return false;
        }
        return true;
    }

    public function update(Request $request, $id){
        
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $tratamiento = Tratamiento::findOrFail($id);
                $tratamiento->detalle = $request->detalle;
                $tratamiento->is_active = $request->is_active;
                $tratamiento->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Tratamiento actualizado.']));
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $tratamiento = Tratamiento::findOrFail($id);
            $tratamiento->is_deleted = true;
            $tratamiento->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Tratamiento Eliminado.']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
