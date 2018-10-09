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

    public static $validation_line_item_rules = [        
        'tratamiento' => 'required',
        'cantidad' => 'required|numeric',
        'monto' => 'required|numeric',
        'total' => 'numeric'
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

    public function lineItem($id){
        $ingresos = DB::select('call OP_obtenerIngresos_Id('. $id .')')[0];
        $hc = $ingresos->hc;
        $ingresos = json_encode($ingresos);
        $ingreso_detalle = DB::select('call OP_obtenerIngresoDetalle_Id('. $id .')');        
        $ingreso_detalle = json_encode($ingreso_detalle);        
        $tratamientos = DB::select('call OP_obtenerTratamientos_PacienteId('. $hc .')');
        $tratamientos = json_encode($tratamientos);

        return view('ingresos.line-item', compact('ingresos', 'ingreso_detalle', 'tratamientos'));
    }

    public function lineItemSave(Request $request){
        $validator = Validator::make($request->all(), self::$validation_line_item_rules );

        if ($validator->passes()) {
            try{

                $ingreso = DB::select('call OP_agregarIngresoDetalle('. $request->ingresoId .', '. $request->precioId .', '. $request->cantidad .', '. $request->monto .')');
                /*
                $ingreso = Ingreso::findOrFail($id);
                $ingreso->idPaciente = $request->idPaciente;
                $ingreso->idMedico = $request->doctor;
                $ingreso->fecha = $request->fecha;                
                $ingreso->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Ingreso modificado correctamente']));
                */  
                $last_ingreso = DB::select('call OP_obtenerUltimoIngresoDetalle_Id('. $request->ingresoId .')')[0];
                $ing_total = DB::select('call OP_obtenerIngresosTotal_Id('. $request->ingresoId .')')[0];
                $total = $ing_total->total;
                $mg = $ing_total->mg;
                $mg_core = $ing_total->mg_core;

                return response()->json(['success' => 'ok', 'last_ingreso' => $last_ingreso->lastIngresoDetalle, 'total' => $total, 'mg' => $mg, 'mg_core' => $mg_core]);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function lineItemUpdate(Request $request, $id){
        $validator = Validator::make($request->all(), self::$validation_line_item_rules );

        if ($validator->passes()) {
            try{

                $ingreso = DB::select('call OP_actualizarIngresoDetalle('. $request->ingresoId .', '. $request->precioId .', '. $request->cantidad .', '. $request->monto .', '. $id  .')');
                 
                $last_ingreso = DB::select('call OP_obtenerUltimoIngresoDetalle_Id('. $request->ingresoId .')')[0];
                $ing_total = DB::select('call OP_obtenerIngresosTotal_Id('. $request->ingresoId .')')[0];
                $total = $ing_total->total;
                $mg = $ing_total->mg;
                $mg_core = $ing_total->mg_core;

                return response()->json(['success' => 'ok', 'last_ingreso' => $last_ingreso->lastIngresoDetalle, 'total' => $total, 'mg' => $mg, 'mg_core' => $mg_core]);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function lineItemDelete($id){
        try{
            $ingreso = DB::select('call OP_eliminarIngresoDetalle('. $id .')');
            
            return response()->json(['success' => 'ok']);
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
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

    public function edit($id)
    {
        $pacientes = DB::select('call OP_obtenerPacientes()');
        $pacientes = json_encode($pacientes);
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);
        $ingreso = DB::select('call OP_obtenerIngresos_Id('. $id .')')[0];
        $ingreso = json_encode($ingreso);

        return view($this->path . '.edit', compact('pacientes', 'doctores', 'ingreso'));
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