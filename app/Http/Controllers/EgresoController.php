<?php

namespace App\Http\Controllers;

use App\Egreso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Validator;

class EgresoController extends Controller{
    public static $validation_rules = [
        'fecha' => 'required|date',
        'tipo' => 'required',
        'doctor' => 'nullable',
        'cantidad' => 'required|numeric',
        'concepto' => 'required',
        'monto' => 'required|numeric',
        'total' => 'numeric',
    ];

    private $path = 'egresos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index()
    {
        $egresos = DB::select('call OP_obtenerEgresos()');
        $egresos = json_encode($egresos);

        return view($this->path . '.index', compact('egresos'));
    }

    public function create()
    {        
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);

        return view($this->path . '.create', compact('doctores'));
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            try{
                $egreso = new Egreso();
                $egreso->fecha = $request->fecha;
                $egreso->tipo = $request->tipo;
                $egreso->doctorId = $request->doctor;
                $egreso->cantidad = $request->cantidad;
                $egreso->concepto = $request->concepto;
                $egreso->precio_unitario = $request->monto;
                $egreso->observacion = $request->nota;
                $egreso->save();
                
                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Egreso registrado correctamente']));
                    
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function show($id)
    {
        $egreso = DB::select('call OP_obtenerEgresos_Id('.$id.')')[0];
        $egreso = json_encode($egreso);
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);

        return view('egresos.show', compact('egreso', 'doctores'));
    }

    public function edit($id)
    {
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);
        $egreso = DB::select('call OP_obtenerEgresos_Id('. $id .')')[0];
        $egreso = json_encode($egreso);

        return view($this->path . '.edit', compact('doctores', 'egreso'));
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            try{
                $egreso = Egreso::findOrFail($id);
                $egreso->fecha = $request->fecha;
                $egreso->tipo = $request->tipo;
                $egreso->doctorId = $request->doctor;
                $egreso->cantidad = $request->cantidad;
                $egreso->concepto = $request->concepto;
                $egreso->precio_unitario = $request->monto;
                $egreso->observacion = $request->nota;
                $egreso->save();     

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Egreso modificado correctamente']));
                    
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id)
    {
        try{
            $egreso = Egreso::findOrFail($id);
            $egreso->is_deleted = true;
            $egreso->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Egreso eliminado correctamente']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
