<?php

namespace App\Http\Controllers;

use App\Empresa;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class EmpresaController extends Controller{

    public static $validation_rules = [
        'nombre' => 'required|max:120',
        'ruc' => 'required|regex:/(^[0-9]{12}$)/u',
        'sucursal' => 'nullable|max:120'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $empresas = DB::select('call OP_ObtenerEmpresas()'); 
        $empresas = json_encode($empresas);
        return view('empresas.index',compact('empresas'));
    }

    public function create(){
        return view('empresas.new');    
    }

    public function show($id){
        $empresa = DB::select('call OP_ObtenerEmpresas_Id('.$id.')')[0];
        $empresa = json_encode($empresa);       
        return view('empresas.show', compact('empresa'));
    }

    public function edit($id){
        $empresa = DB::select('call OP_ObtenerEmpresas_Id('.$id.')')[0];
        $empresa = json_encode($empresa);       
        return view('empresas.edit', compact('empresa'));
    }
    
    public function store(Request $request){
        
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                DB::beginTransaction();

                $empresa = new Empresa();
                $empresa->nombre = $request->nombre;
                $empresa->ruc = $request->ruc;
                $empresa->sucursal = $request->sucursal;
                $empresa->save();
                $pricesInserted = self::insertTreatmentsStandardPrices($empresa->id);

                if($pricesInserted){
                    DB::commit();
                    $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Empresa registrada correctamente']));
                    return response()->json(['success' => 'success']);
                }else{
                    DB::rollback();
                    return response()->json(['error' => 'Ha ocurrido un error al insertar la empresa o sus precios']);
                }
            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function insertTreatmentsStandardPrices($companyId){
        $prices = DB::select('call OP_ObtenerPreciosEstandard()');
         
        foreach ($prices as $price) {
            $status = DB::select('call OP_AgregarPrecios_EmpresaId_TratamientoId('.$companyId.','.$price->id_tratamiento.','.$price->monto.')');
            if($status == 0) return false;
        }
        return true;
    }

    public function update(Request $request, $id){
        
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $empresa = Empresa::findOrFail($id);
                $empresa->nombre = $request->nombre;
                $empresa->ruc = $request->ruc;
                $empresa->sucursal = $request->sucursal;
                $empresa->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Empresa actualizada.']));
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $empresa = Empresa::findOrFail($id);
            $empresa->is_deleted = true;
            $empresa->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Empresa Eliminada.']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
