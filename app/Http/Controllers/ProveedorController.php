<?php

namespace App\Http\Controllers;

use App\Proveedor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ProveedorController extends Controller{

    public static $validation_rules = [
        'nombres' => 'required|max:100',
        'email' => 'nullable|max:120',
        'direccion' => 'nullable|max:100',
        'dni' => 'nullable|regex:/(^[0-9]{8}$)/u',
        'telefono' => 'nullable|max:60',
        'celular' => 'nullable|max:60',
        'empresa' => 'nullable|max:120',
        'ciudad' => 'nullable|max:100',
        'ruc' => 'nullable|regex:/(^[0-9]{11}$)/u',
        'banco' => 'nullable|max:60',
        'nrocuenta' => 'nullable|max:60',
        'insumo_id' => 'required',
        'tipo_id' => 'required'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $proveedores = DB::select('call OP_Proveedores_get_all()');
        $proveedores = json_encode($proveedores);
        return view('proveedores.index',compact('proveedores'));
    }

    public function create(){
        return view('proveedores.new');
    }

    public function show($id){
        $proveedor = DB::select('call OP_Proveedores_get_all_Id('.$id.')')[0];
        $proveedor = json_encode($proveedor);
        return view('proveedores.show', compact('proveedor'));
    }

    public function edit($id){
        $proveedor = DB::select('call OP_Proveedores_get_all_Id('.$id.')')[0];
        $proveedor = json_encode($proveedor);
        return view('proveedores.edit', compact('proveedor'));
    }

    public function store(Request $request){

    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $proveedor = new Proveedor();
                $proveedor->nombres = $request->nombres;
                $proveedor->email = $request->email;
                $proveedor->direccion = $request->direccion;
                $proveedor->dni = $request->dni;
                $proveedor->telefono = $request->telefono;
                $proveedor->celular = $request->celular;
                $proveedor->empresa = $request->empresa;
                $proveedor->ciudad = $request->ciudad;
                $proveedor->ruc = $request->ruc;
                $proveedor->banco = $request->banco;
                $proveedor->nrocuenta = $request->nrocuenta;
                $proveedor->insumo_id = $request->insumo_id;
                $proveedor->tipo_id = $request->tipo_id;
                $proveedor->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Proveedor/Laboratorio registrado correctamente']));

                return response()->json(['success' => 'success']);

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
                $proveedor = Proveedor::findOrFail($id);
                $proveedor->nombres = $request->nombres;
                $proveedor->email = $request->email;
                $proveedor->direccion = $request->direccion;
                $proveedor->dni = $request->dni;
                $proveedor->telefono = $request->telefono;
                $proveedor->celular = $request->celular;
                $proveedor->empresa = $request->empresa;
                $proveedor->ciudad = $request->ciudad;
                $proveedor->ruc = $request->ruc;
                $proveedor->banco = $request->banco;
                $proveedor->nrocuenta = $request->nrocuenta;
                $proveedor->insumo_id = $request->insumo_id;
                $proveedor->tipo_id = $request->tipo_id;
                $proveedor->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Proveedor/Laboratorio actualizado.']));
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $proveedor = Proveedor::findOrFail($id);
            $proveedor->is_deleted = true;
            $proveedor->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Proveedor/Laboratorio Eliminado.']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
