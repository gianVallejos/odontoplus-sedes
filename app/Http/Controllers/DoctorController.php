<?php

namespace App\Http\Controllers;

use App\Doctor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DoctorController extends Controller{

    public static $validation_rules = [
        'nombres' => 'required|max:90',
        'apellidos' => 'required|max:90',
        'dni' => 'required|regex:/(^[0-9]{8}$)/u',
        'email' => 'max:90',
        'direccion' => 'required|max:90',
        'fechanacimiento' => 'required',
        'genero' => 'required|max:25',
        'estado' => 'required|max:25',
        'telefono' => 'nullable|max:50',
        'celular' => 'nullable|max:50',
        'celular_aux' => 'nullable|max:50',
        'margen_ganancia' => 'nullable|min:0|max:100'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $doctors = DB::select('call OP_ObtenerDoctores()'); 
        $doctors = json_encode($doctors);
        return view('doctors.index',compact('doctors'));
    }

    public function create(){
        return view('doctors.new');    
    }

    public function show($id){
        $doctor = DB::select('call OP_ObtenerDoctores_Id('.$id.')')[0];
        $doctor = json_encode($doctor);       
        return view('doctors.show', compact('doctor'));
    }

    public function edit($id){
        $doctor = DB::select('call OP_ObtenerDoctores_Id('.$id.')')[0];
        $doctor = json_encode($doctor);       
        return view('doctors.edit', compact('doctor'));
    }
    
    public function store(Request $request){
        
    	$validator = Validator::make($request->all(), self::$validation_rules );

    	if ($validator->passes()) {
            try{
                $doctor = new Doctor();
                $doctor->nombres = $request->nombres;
                $doctor->apellidos = $request->apellidos;
                $doctor->dni = $request->dni;
                $doctor->email = $request->email;
                $doctor->direccion = $request->direccion;
                $doctor->fechanacimiento = $request->fechanacimiento;
                $doctor->genero = $request->genero;
                $doctor->estado = $request->estado;
                $doctor->telefono = $request->telefono;
                $doctor->celular = $request->celular;
                $doctor->celular_aux = $request->celular_aux;
                $doctor->margen_ganancia = $request->margen_ganancia;
                $doctor->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Doctor registrado correctamente']));
                    
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
                $doctor = Doctor::findOrFail($id);
                $doctor->nombres = $request->nombres;
                $doctor->apellidos = $request->apellidos;
                $doctor->dni = $request->dni;
                $doctor->email = $request->email;
                $doctor->direccion = $request->direccion;
                $doctor->fechanacimiento = $request->fechanacimiento;
                $doctor->genero = $request->genero;
                $doctor->estado = $request->estado;
                $doctor->telefono = $request->telefono;
                $doctor->celular = $request->celular;
                $doctor->celular_aux = $request->celular_aux;
                $doctor->margen_ganancia = $request->margen_ganancia;
                $doctor->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Doctor actualizado.']));
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $doctor = Doctor::findOrFail($id);
            $doctor->is_deleted = true;
            $doctor->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Doctor Eliminado.']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
