<?php

namespace App\Http\Controllers;

use App\Paciente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use Validator;

class PacienteController extends Controller
{
    private $path = 'pacientes';
    public function __construct(){
        $this->middleware('auth');
    }

    public static $validation_rules = [
        'nombres' => 'required|string|max:90',
        'apellidos' => 'required|string|max:90',
        'dni' => 'required|digits:8',
        'direccion' => 'required|string|max:90',
        'fechanacimiento' => 'required|date|before:now',
        'email' => 'nullable|email|max:90',
        'genero' => 'nullable|string|max:25',
        'estado' => 'nullable|string|max:25',
        'telefono' => 'nullable|string|max:50',
        'fax' => 'nullable|string|max:50',
        'celular' => 'nullable|string|max:50',
        'celular_aux' => 'nullable|string|max:50',
        'empresa_id' => 'nullable',
        'seguro_ind' => 'nullable',
        'nombre_apoderado' => 'nullable|string|max:150',
        'celular_apoderado' => 'nullable|string|max:150',
    ];

    private function getEighteenYearsFromNow(){
        $mytime = Carbon::now()->subYears(18);
        return $mytime->toDateString();
    }

    public function index(){
        $pacientes = DB::select('call OP_obtenerPacientes()'); 
        $pacientes = json_encode($pacientes);
                
        return view($this->path.'.index', compact('pacientes'));
    }

    public function create(){
        $empresas = DB::select('call OP_ObtenerEmpresas()');
        $empresas = json_encode($empresas);        

        return view($this->path . '.create', compact('empresas'));    
    }

    public function show($id){        
        $paciente = DB::select('call OP_obtenerPacientes_Id('. $id .')')[0]; 
        $paciente = json_encode($paciente);        
        $empresas = DB::select('call OP_ObtenerEmpresas()');
        $empresas = json_encode($empresas);

        return view($this->path . '.show', compact('empresas', 'paciente'));
    }

    public function edit($id){
        $paciente = DB::select('call OP_obtenerPacientes_Id('. $id .')')[0]; 
        $paciente = json_encode($paciente);        
        $empresas = DB::select('call OP_ObtenerEmpresas()');
        $empresas = json_encode($empresas);
        
        return view($this->path . '.edit', compact('empresas', 'paciente'));
    }

    public function store(Request $request){
        //print_r($request->all()); die();
        $validator = Validator::make($request->all(), self::$validation_rules );
        $validator->sometimes(['nombre_apoderado', 'celular_apoderado'], 'required', function($input){            
            return $input->fechanacimiento > self::getEighteenYearsFromNow();
        });

        if ($validator->passes()) {
            try{
                $paciente = new Paciente();

                $paciente->nombres = $request->nombres;
                $paciente->apellidos = $request->apellidos;
                $paciente->dni = $request->dni;
                $paciente->email = $request->email;
                $paciente->fechanacimiento = $request->fechanacimiento;
                $paciente->genero = $request->genero;
                $paciente->estado = $request->estado;
                $paciente->direccion = $request->direccion;
                $paciente->telefono = $request->telefono;
                $paciente->fax = $request->fax;
                $paciente->celular = $request->celular;
                $paciente->celular_aux = $request->celular_aux;
                $paciente->empresa_id = $request->empresa_id;
                $paciente->seguro_ind = $request->seguro_ind;
                $paciente->nombre_apoderado = $request->nombre_apoderado;
                $paciente->celular_apoderado = $request->celular_apoderado;
                $paciente->save();
                    
                return response()->json(['success' => 'created']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }

        return response()->json(['error'=>$validator->errors()]);
    }
        
    public function update(Request $request, $id){
        
        $validator = Validator::make($request->all(), self::$validation_rules );
        $validator->sometimes(['nombre_apoderado', 'celular_apoderado'], 'required', function($input){            
            return $input->fechanacimiento > self::getEighteenYearsFromNow();
        });

        if ($validator->passes()) {
            try{
                $paciente = Paciente::findOrFail($id);

                $paciente->nombres = $request->nombres;
                $paciente->apellidos = $request->apellidos;
                $paciente->dni = $request->dni;
                $paciente->email = $request->email;
                $paciente->fechanacimiento = $request->fechanacimiento;
                $paciente->genero = $request->genero;
                $paciente->estado = $request->estado;
                $paciente->direccion = $request->direccion;
                $paciente->telefono = $request->telefono;
                $paciente->fax = $request->fax;
                $paciente->celular = $request->celular;
                $paciente->celular_aux = $request->celular_aux;
                $paciente->empresa_id = $request->empresa_id;
                $paciente->seguro_ind = $request->seguro_ind;
                $paciente->nombre_apoderado = $request->nombre_apoderado;
                $paciente->celular_apoderado = $request->celular_apoderado;
                $paciente->save();
                    
                return response()->json(['success' => 'updated']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $canDelete = DB::select('call OP_esPacienteBorrable_Id('. $id .')');
            if( $canDelete[0]->CAN_DELETE == '1' ){
                $res = DB::select('call OP_eliminarPaciente_Id('. $id .')');

                return response()->json(['success' => 'deleted']);
            }else{
                return response()->json(['error' => 'cantDeleted']);
            }
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
