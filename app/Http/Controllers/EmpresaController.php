<?php

namespace App\Http\Controllers;

use App\Empresa;
use Illuminate\Http\Request;
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
        $empresas = DB::select('call OP_ObtenerEmpresas()'); 
        $empresas = json_encode($empresas);

        return view('empresas.index', compact('empresas'));
    }

    public function create(){
        return view('empresas.create');    
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
                $empresa = new Empresa();
                $empresa->nombre = $request->nombre;
                $empresa->ruc = $request->ruc;
                $empresa->save();

                return response()->json(['success' => 'created']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }

        return response()->json(['error' => $validator->errors()]);
    }

    public function update(Request $request, $id){
        
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $empresa = Empresa::findOrFail($id);
                $empresa->nombre = $request->nombre;
                $empresa->ruc = $request->ruc;
                $empresa->save();

                return response()->json(['success' => 'updated']);

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

            return response()->json(['success' => 'deleted']);
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
