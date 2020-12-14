<?php

namespace App\Http\Controllers;

use App\Paciente;
use App\Ingreso;
use App\CustomLibs\CurBD;
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

    //public static $validation_rules = ;

    private function getEighteenYearsFromNow(){
        $mytime = Carbon::now()->subYears(18);
        return $mytime->toDateString();
    }

    public function index(){
        $db = DB::connection(CurBD::getCurrentSchema());
        $pacientes = $db->select('call OP_Pacientes_get_all()');
        $pacientes = json_encode(collect($pacientes));
        return view($this->path.'.index', compact('pacientes'));
    }

    public function create(){
        $db = DB::connection(CurBD::getCurrentSchema());
        $codigo = $db->select('call OP_Pacientes_generar_codigo(?)', array(CurBD::getCurrentSede()));
        $codigo = json_encode(collect($codigo)[0]->codigo);
        //$codigo = $db->select('call OP_Pacientes_generar_codigo('. CurBD::getCurrentSede() .')')[0]->codigo;
        $empresas =  $db->select('call OP_Empresas_get_all()');
        $empresas = json_encode(collect($empresas));
        $sedes =  $db->select('call OP_Sedes_get_all()');
        $sedes = json_encode(collect($sedes));
        $referencias =  $db->select('call OP_Referencias_get_all()');
        $referencias = json_encode(collect($referencias));

        return view($this->path . '.create', compact('empresas', 'referencias', 'sedes', 'codigo'));
    }

    public function show($id){
        $db = DB::connection(CurBD::getCurrentSchema());
        $paciente =  $db->select('call OP_Pacientes_get_all_Id(?)', array($id));
        $paciente = json_encode(collect($paciente)[0]);
        $empresas =  $db->select('call OP_Empresas_get_all()');
        $empresas = json_encode(collect($empresas));
        $sedes =  $db->select('call OP_Sedes_get_all()');
        $sedes = json_encode(collect($sedes));
        $referencias =  $db->select('call OP_Referencias_get_all()');
        $referencias = json_encode(collect($referencias));

        return view($this->path . '.show', compact('empresas', 'paciente', 'referencias', 'sedes'));
    }

    public function edit($id){
        $db = DB::connection(CurBD::getCurrentSchema());
        $paciente =  $db->select('call OP_Pacientes_get_all_Id(?)', array($id));
        $paciente = json_encode(collect($paciente)[0]);
        $empresas =  $db->select('call OP_Empresas_get_all()');
        $empresas = json_encode(collect($empresas));
        $sedes =  $db->select('call OP_Sedes_get_all()');
        $sedes = json_encode(collect($sedes));
        $referencias =  $db->select('call OP_Referencias_get_all()');
        $referencias = json_encode(collect($referencias));

        return view($this->path . '.edit', compact('empresas', 'paciente', 'referencias', 'sedes'));
    }

    public function store(Request $request){
        //print_r($request->all()); die();
        $validator = Validator::make($request->all(), [
                                    'codigo' => 'required|unique:'.CurBD::getCurrentSchema().'.pacientes|string|max:200',
                                    'nombres' => 'required|string|max:90',
                                    'apellidos' => 'required|string|max:90',
                                    'dni' => 'required|unique:'.CurBD::getCurrentSchema().'.pacientes|digits:8',
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
                                    'referencia_id' => 'nullable',
                                    'nombre_apoderado' => 'nullable|string|max:150',
                                    'celular_apoderado' => 'nullable|string|max:150',
                                    'sede_id' => 'required',
                                ] );
        $validator->sometimes(['nombre_apoderado', 'celular_apoderado'], 'required', function($input){
            return $input->fechanacimiento > self::getEighteenYearsFromNow();
        });

        if ($validator->passes()) {
            //DB::beginTransaction();
            $db = DB::connection(CurBD::getCurrentSchema());
            $paciente =  $db->select('call OP_Pacientes_add_all(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)',
                                      array(
                                        $request->nombres, $request->apellidos, $request->dni,
                                        $request->email, $request->direccion, $request->fechanacimiento,
                                        $request->genero, $request->estado, $request->telefono, 
                                        $request->fax, $request->celular, $request->celular_aux,
                                        $request->empresa_id, $request->seguro_ind, $request->nombre_apoderado,
                                        $request->celular_apoderado, $request->referencia_id, $request->sede_id, 
                                        $request->codigo
                                      ));
            $paciente = collect($paciente)[0];
            if( $paciente->ESTADO > 0 ){
              $ingreso =  $db->select('call OP_Ingresos_add_all(?)', array($paciente->LAST_ID));
              $ingreso = collect($ingreso)[0];
              if( $ingreso->ESTADO > 0 ){
                //DB::commit();
                return response()->json(['success' => 'created', 'id_created' => $paciente->LAST_ID]);
              }else{
                //DB::rollback();
                return response()->json(['error' => 'Ha ocurrido un error']);
              }
            }else{
              //DB::rollback();
              return response()->json(['error' => 'Ha ocurrido un error']);
            }
        }

        return response()->json(['error'=>$validator->errors()]);
    }

    public function update(Request $request, $id){

        $validator = Validator::make($request->all(), [
                        'codigo' => 'required|string|max:200',
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
                        'referencia_id' => 'nullable',
                        'nombre_apoderado' => 'nullable|string|max:150',
                        'celular_apoderado' => 'nullable|string|max:150',
                        'sede_id' => 'required',
                    ] );
        $validator->sometimes(['nombre_apoderado', 'celular_apoderado'], 'required', function($input){
            return $input->fechanacimiento > self::getEighteenYearsFromNow();
        });

        if ($validator->passes()) {
            $db = DB::connection(CurBD::getCurrentSchema());
            $paciente =  $db->select('call OP_Pacientes_update_all_Id(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
                                      array(
                                        $request->nombres, $request->apellidos, $request->dni, $request->email,
                                        $request->direccion, $request->fechanacimiento, $request->genero,
                                        $request->estado, $request->telefono, $request->fax, $request->celular,
                                        $request->celular_aux, $request->empresa_id, $request->seguro_ind,
                                        $request->nombre_apoderado, $request->celular_apoderado,
                                        $request->referencia_id, $request->sede_id, $id
                                      )
                                    );
            $paciente = collect($paciente)[0];
            if( $paciente->ESTADO > 0 ){
              return response()->json(['success' => 'updated']);
            }else{
              return response()->json(['error' => 'Ha ocurrido un error']);
            }
        }

        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $db = DB::connection(CurBD::getCurrentSchema());
            $canDelete =  $db->select('call OP_Pacientes_es_borrable_Id(?)', array($id));
            $canDelete = collect($canDelete)[0];
            if( $canDelete->CAN_DELETE == '1' ){
                $res =  $db->statement('call OP_Pacientes_delete_by_update_Id(?)', array($id));
                $res2 =  $db->statement('call OP_Ingresos_delete_by_update_Id(?)', array($id));
                return response()->json(['success' => 'deleted']);
            }else{
                return response()->json(['error' => 'cantDeleted']);
            }
        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
