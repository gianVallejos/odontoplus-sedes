<?php

namespace App\Http\Controllers;

use App\Doctor;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DoctorController extends Controller{

    public static $validation_rules = [
        'nombres' => 'required|string|max:90',
        'apellidos' => 'required|string|max:90',
        'dni' => 'required|digits:8',
        'email' => 'nullable|email|max:90',
        'direccion' => 'required|string|max:90',
        'fechanacimiento' => 'required|date',
        'genero' => 'nullable|string|max:25',
        'estado' => 'nullable|string|max:25',
        'telefono' => 'nullable|string|max:50',
        'celular' => 'nullable|string|max:50',
        'celular_aux' => 'nullable|string|max:50',
        'margen_ganancia' => 'nullable|min:0|max:100'
    ];

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $doctors = DB::select('call OP_ObtenerDoctores_DESC()'); 
        $doctors = json_encode($doctors);
        
        return view('doctors.index',compact('doctors'));
    }

    public function create(){

        return view('doctors.create');    
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
                    
                return response()->json(['success' => 'created']);

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

                return response()->json(['success' => 'updated']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $canDelete = DB::select('call OP_esDoctorBorrable_Id('. $id .')');
            if( $canDelete[0]->CAN_DELETE == '1' ){
                $res = DB::select('call OP_eliminarDoctor_Id('. $id .')');

                return response()->json(['success' => 'deleted']);
            }else{
                return response()->json(['error' => 'cantDeleted']);
            }

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
