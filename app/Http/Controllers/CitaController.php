<?php

namespace App\Http\Controllers;
use App\CustomLibs\CurBD;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class CitaController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      return view('citas.index');
    }

    public function getEventsCitas(){
      $citas = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all()');

      return response()->json($citas);
    }

    public function changeFechaCita($fecha, $id){
      $res = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_update_fecha_cita("'. $fecha .'", '. $id .')');      
      if( $res[0]->ESTADO > 0 ){
         return response()->json(['success' => 'updated']);
      }else{
         return response()->json(['error'=> 'Ha ocurrido un error']);
      }
    }

    public function create(){
      $pacientes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode($pacientes);
      $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
      $doctores = json_encode($doctores);

      return view('citas.create', compact('pacientes', 'doctores'));
    }

    public function show($id){
      $pacientes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode($pacientes);
      $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
      $doctores = json_encode($doctores);
      $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all_id('. $id .')')[0];
      $cita = json_encode($cita);

      return view('citas.show', compact('pacientes', 'doctores', 'cita'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'paciente' => 'required|string|max:200',
            'fecha' => 'required|date',
            'desde' => 'required|date_format:H:i',
            'hasta' => 'required|date_format:H:i|after:desde',
            'idPaciente' => 'required|integer',
            'idDoctor' => 'required|integer'
        ]);

    	if ($validator->passes()) {
            $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_add_all("'. $request->paciente .'", "'. $request->fecha .'", "'.
                                                                                                 $request->desde .'", "'. $request->hasta .'", '.
                                                                                                 $request->idPaciente .','. $request->idDoctor.')');
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
            'paciente' => 'required|string|max:200',
            'fecha' => 'required|date',
            'desde' => 'required',
            'hasta' => 'required|after:desde',
            'idPaciente' => 'required|integer',
            'idDoctor' => 'required|integer'
        ]);

    	if ($validator->passes()) {

          $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_update_all('.$id.', "'. $request->paciente . '", "' . $request->fecha .'", "'.
                                                                                                $request->desde .'", "'. $request->hasta .'",' .
                                                                                                $request->idPaciente .','. $request->idDoctor.')'   );
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
        return response()->json(['success' => 'deleted']);
    }

}
