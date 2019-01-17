<?php

namespace App\Http\Controllers;
use App\CustomLibs\CurBD;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use App\Mail\CitaProgramada;

class CitaController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $doctores = DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
      $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');

      return view('citas.index', compact('doctores', 'sedes'));
    }

    public function getEventsFiltered($idDoctor, $idSede){
      $citas = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all_by_doctor_sede('. $idDoctor .','. $idSede .')');

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
      $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
      $sedes = json_encode($sedes);
      $sillons = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sillons_get_all()');
      $sillons = json_encode($sillons);

      return view('citas.create', compact('pacientes', 'doctores', 'sedes', 'sillons'));
    }

    public function show($id){
      $pacientes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode($pacientes);
      $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
      $doctores = json_encode($doctores);
      $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
      $sedes = json_encode($sedes);
      $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all_id('. $id .')')[0];
      $cita = json_encode($cita);
      $sillons = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sillons_get_all()');
      $sillons = json_encode($sillons);

      return view('citas.show', compact('pacientes', 'doctores', 'cita', 'sedes', 'sillons'));
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'paciente' => 'nullable|string|max:200',
            'fecha' => 'required|date',
            'desde' => 'required|date_format:H:i',
            'hasta' => 'required|date_format:H:i|after:desde',
            'tratamiento' => 'required|string|max:200',
            'sillon' => 'required|integer',
            'sede' => 'required|integer',
            'idPaciente' => 'nullable|integer',
            'idDoctor' => 'required|integer',
            'nota' => 'nullable|string|max:200'
        ]);

    	if ($validator->passes()) {
          $es_valido = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_is_validate_range("'. $request->fecha .'", "'. $request->desde .'", "'.
                                                                                                                $request->hasta .'", '. $request->sillon .', '. $request->sede .')');
          if( $es_valido[0]->ES_VALIDO == 0 ){ //Si la cita no es válida
            return response()->json(['success' => 'no_valido']);
          }else{
              if( $request->idPaciente == null ){
                $request->idPaciente = 0;
              }
              $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_add_all("'. $request->paciente. '","' . $request->tratamiento . '", "'. $request->fecha .'", "'.
                                                                                                   $request->desde .'", "'. $request->hasta .'", "'.
                                                                                                   $request->idPaciente .'",'. $request->idDoctor.','. $request->sede.','. $request->sillon.', "'. $request->nota .'")');
              if( $cita[0]->ESTADO > 0 ){
                 if ($request->enviarEmail) {
                   $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all_id('. $request->sede .')')[0];
                   self::sendNotificationEmail($request->idPaciente, date('d-m-Y', strtotime($request->fecha) ), $request->desde, $sedes->direccion);
                 }
                 return response()->json(['success' => 'created']);
              }else{
                 return response()->json(['error'=> 'Ha ocurrido un error']);
              }
          }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function update(Request $request, $id){
      $validator = Validator::make($request->all(), [
            'paciente' => 'nullable|string|max:200',
            'fecha' => 'required|date',
            'desde' => 'required',
            'hasta' => 'required|after:desde',
            'tratamiento' => 'required|string|max:200',
            'sillon' => 'required|integer',
            'idPaciente' => 'nullable|integer',
            'idDoctor' => 'required|integer',
            'sede' => 'required|integer',
            'nota' => 'nullable|string|max:200'
        ]);

    	if ($validator->passese()) {
        /*
        $es_valido = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_is_validate_range("'. $request->fecha .'", "'. $request->desde .'", "'.
                                                                                                              $request->hasta .'", '. $request->sillon .', '. $request->sede .')');
        if( $es_valido[0]->ES_VALIDO == 0 ){ //Si la cita no es válida
            return response()->json(['success' => 'no_valido']);
        }else{
        */
            if( $request->idPaciente == null ){
              $request->idPaciente = 0;
            }
            $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_update_all('.$id.',"'. $request->idPaciente. '","' . $request->tratamiento . '", "'. $request->fecha .'", "'.
                                                                                                 $request->desde .'", "'. $request->hasta .'",'. $request->idDoctor.','. $request->sede.','.
                                                                                                 $request->sillon .', "'. $request->nota .' ")');
            if( $cita[0]->ESTADO > 0 ){
              if ($request->enviarEmail) {
                $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all_id('. $request->sede .')')[0];
                self::sendNotificationEmail($request->idPaciente, date('d-m-Y', strtotime($request->fecha) ), $request->desde, $sedes->direccion);
              }
              return response()->json(['success' => 'updated']);
            }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
            }
        // }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy($id){
        $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_delete_all_Id('. $id .')');
        return response()->json(['success' => 'deleted']);
    }

    public function sendNotificationEmail($idPaciente, $fecha, $hora_inicio, $direccion){
      $cliente = json_decode(CurBD::getCurrentClienteData());
      $paciente =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all_Id('. $idPaciente .')')[0];
      if ($paciente->email != '') {
        Mail::to($paciente->email)->send(new CitaProgramada($paciente->nombres, $fecha, $hora_inicio, $cliente, $direccion));
      }
    }

}
