<?php

namespace App\Http\Controllers;

use App\Ingreso;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Validator;

class IngresoController extends Controller
{    
    public static $validation_rules = [
        'fecha' => 'required|date',
        'paciente' => 'required',
        'doctor' => 'required'
    ];

    private $path = 'ingresos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $ingresos = DB::select('call OP_obtenerIngresos()');
        $ingresos = json_encode($ingresos);

        return view($this->path . '.index', compact('ingresos'));
    }

    public function create()
    {
        $pacientes = DB::select('call OP_obtenerPacientes()');
        $pacientes = json_encode($pacientes);
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);

        return view($this->path . '.create', compact('pacientes', 'doctores'));
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            try{
                $ingreso = new Ingreso();
                $ingreso->idPaciente = $request->idPaciente;
                $ingreso->idMedico = $request->doctor;
                $ingreso->fecha = $request->fecha;                
                $ingreso->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Ingreso registrado correctamente']));
                    
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function show($id){
        $ingreso = DB::select('call OP_obtenerIngresos_Id('.$id.')')[0];
        $ingreso = json_encode($ingreso);
        $pacientes = DB::select('call OP_obtenerPacientes()');
        $pacientes = json_encode($pacientes);
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);

        return view('ingresos.show', compact('ingreso', 'pacientes', 'doctores'));
    }

    public function edit(Ingreso $ingreso)
    {
        //
    }

    public function update(Request $request, $id){
        $validator = Validator::make($request->all(), self::$validation_rules );

        if ($validator->passes()) {
            try{
                $ingreso = Ingreso::findOrFail($id);
                $ingreso->idPaciente = $request->idPaciente;
                $ingreso->idMedico = $request->doctor;
                $ingreso->fecha = $request->fecha;                
                $ingreso->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Ingreso modificado correctamente']));
                    
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
            $ingreso = Ingreso::findOrFail($id);
            $ingreso->is_deleted = true;
            $ingreso->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Ingreso eliminado correctamente']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
