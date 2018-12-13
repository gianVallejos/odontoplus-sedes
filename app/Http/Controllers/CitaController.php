<?php

namespace App\Http\Controllers;
use App\CustomLibs\CurBD;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CitaController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all()');
        return view('citas.index', compact('cita'));
    }

    public function create(){
      $pacientes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode($pacientes);
      $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
      $doctores = json_encode($doctores);

      return view('citas.create', compact('pacientes', 'doctores'));
    }

    public function show($id){
        $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all_id('.$id.')')[0];
        return response()->json(['cita' => $cita ]);
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'titulo' => 'required|string|max:200',
            'desde' => 'required',
            'hasta' => 'required',
            'idPaciente' => 'required|integer',
            'idDoctor' => 'required|integer'
        ]);

    	if ($validator->passes()) {
            $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_add_all("'. $request->titulo .'", "'. $request->desde .'", "'. $request->hasta
                                                           .'",'. $request->idPaciente .','. $request->idDoctor.')');
            if( $cita[0]->ESTADO > 0 ){
               return response()->json(['success' => 'created']);
            }else{
               return response()->json(['error'=> 'Ha ocurrido un error']);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function update(Request $request, $id){
        $validator = Validator::make($request->all(), [
            'titulo' => 'required|string|max:200',
            'desde' => 'required',
            'hasta' => 'required',
            'idPaciente' => 'required|integer',
            'idDoctor' => 'required|integer'
        ]);

    	if ($validator->passes()) {

          $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_update_all('.$id.',"'. $request->titulo .'", "'. $request->desde .'", "'. $request->hasta
                                                         .'",'. $request->idPaciente .','. $request->idDoctor.')'   );
          if( $cita[0]->ESTADO > 0 ){
              return response()->json(['success' => 'updated']);
          }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
          }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy($id){
        $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_delete_all_Id('. $id .')');
        if( $cita[0]->ESTADO > 0 ){
            return response()->json(['success' => 'deleted']);
        }else{
            return response()->json(['error'=> 'Ha ocurrido un error']);
        }
    }

}
