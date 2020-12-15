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
      $db = DB::connection(CurBD::getCurrentSchema());
      $doctores = $db->select('call OP_Doctors_get_all()');
      $doctores = collect($doctores);
      $sedes = $db->select('call OP_Sedes_get_all()');
      $sedes = collect($sedes);
      return view('citas.index', compact('doctores', 'sedes'));
    }

    public function getEventsFiltered($idDoctor, $idSede){       
      $idDoctor = ($idDoctor == 'null') ? null : $idDoctor;     
      $idSede = ($idSede == 'null') ? null : $idSede;
      $db = DB::connection(CurBD::getCurrentSchema());      
      $citas = $db->select('call OP_Citas_get_all_by_doctor_sede(?,?)', array($idDoctor, $idSede));
      $citas = collect($citas);      
      return response()->json($citas);
    }

    public function changeFechaCita($fecha, $id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $res = $db->select('call OP_Citas_update_fecha_cita(?,?)', array($fecha, $id));
      $res = collect($res)[0];
      if( $res->ESTADO > 0 ){
         return response()->json(['success' => 'updated']);
      }else{
         return response()->json(['error'=> 'Ha ocurrido un error']);
      }
    }

    public function create(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $pacientes =  $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode(collect($pacientes));
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode(collect($doctores));
      $sedes = $db->select('call OP_Sedes_get_all()');
      $sedes = json_encode(collect($sedes));
      $sillons = $db->select('call OP_Sillons_get_all()');
      $sillons = json_encode(collect($sillons));

      return view('citas.create', compact('pacientes', 'doctores', 'sedes', 'sillons'));
    }

    public function show($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $pacientes =  $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode(collect($pacientes));
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode(collect($doctores));
      $sedes = $db->select('call OP_Sedes_get_all()');
      $sedes = json_encode(collect($sedes));
      $cita = $db->select('call OP_Citas_get_all_id(?)', array($id));
      $cita = json_encode(collect($cita)[0]);
      $sillons = $db->select('call OP_Sillons_get_all()');
      $sillons = json_encode(collect($sillons));

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
        $db = DB::connection(CurBD::getCurrentSchema());
        $fecha = $request->fecha;
        $desde = $request->desde;
        $hasta = $request->hasta;
        $idDoctor = $request->idDoctor;
        $sillon = $request->sillon;
        $sede = $request->sede;
        
        $es_valido_sede = $db->select('call OP_Citas_is_validate_range_not_sede_and_sillon(?,?,?,?)', 
                                       array($fecha, $desde, $hasta, $idDoctor)
                                     );
        $es_valido_sede = collect($es_valido_sede)[0];
        if($es_valido_sede->ES_VALIDO == 0){
          return response()->json(['success' => 'no_valido_sede']);
        }else{
          $es_valido = $db->select('call OP_Citas_is_validate_range(?,?,?,?,?)',
                                    array(
                                      $fecha, $desde, $hasta,
                                      $sillon, $sede)
                                  );
          $es_valido = collect($es_valido)[0];
          if( $es_valido->ES_VALIDO == 0 ){ //Si la cita no es válida
            return response()->json(['success' => 'no_valido']);
          }else{
            if( $request->idPaciente == null ){
              $request->idPaciente = 0;
            }
            $paciente = $request->paciente;
            $tratamiento = $request->tratamiento;
            $idPaciente = $request->idPaciente;
            $idDoctor = $request->idDoctor;
            $nota = $request->nota;
            $cita = $db->select('call OP_Citas_add_all(?,?,?,?,?,?,?,?,?,?)', 
                                 array(
                                        $paciente, $tratamiento, $fecha, 
                                        $desde, $hasta, $idPaciente, 
                                        $idDoctor, $sede, $sillon, $nota
                                      )
                                );
            $cita = collect($cita)[0];
            if( $cita->ESTADO > 0 ){
              /*
              if ($request->enviarEmail) {
                  $sedes = $db->select('call OP_Sedes_get_all_id(?)', array($request->sede));
                  $sedes = collect($sedes)[0];
                  self::sendNotificationEmail($request->idPaciente, date('d-m-Y', strtotime($request->fecha) ), $request->desde, $sedes->direccion);
              }*/
              return response()->json(['success' => 'created']);
            }else{
                return response()->json(['error'=> 'Ha ocurrido un error']);
            }
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

    	if ($validator->passes()) {
        $db = DB::connection(CurBD::getCurrentSchema());
        $es_valido = $db->select('call OP_Citas_is_validate_range_Id(?,?,?,?,?,?)', 
                                  array($request->fecha, $request->desde, 
                                        $request->hasta, $request->sillon,
                                        $request->sede, $id)
                                );
        $es_valido = collect($es_valido)[0];
        // print_r($es_valido); die();
        if( $es_valido->ES_VALIDO == 0 ){ //Si la cita no es válida
            return response()->json(['success' => 'no_valido']);
        }else{
            if( $request->idPaciente == null ){
              $request->idPaciente = 0;
            }
            $paciente = $request->paciente;
            $idPaciente = $request->idPaciente;
            $tratamiento = $request->tratamiento;
            $fecha = $request->fecha;
            $desde = $request->desde;
            $hasta = $request->hasta;
            $idDoctor = $request->idDoctor;
            $sede = $request->sede;
            $sillon = $request->sillon;
            $nota = $request->nota;
            $cita = $db->select('call OP_Citas_update_all(?,?,?,?,?,?,?,?,?,?,?)', 
                                  array(
                                        $id, $paciente, $idPaciente, $tratamiento, $fecha, 
                                        $desde, $hasta, $idDoctor, $sede,
                                        $sillon, $nota
                                      )
                                );
            $cita = collect($cita)[0];
            if( $cita->ESTADO > 0 ){
              if ($request->enviarEmail) {
                $sedes = $db->select('call OP_Sedes_get_all_id(?)', array($request->sede));
                $sedes = collect($sedes)[0];
                self::sendNotificationEmail($request->idPaciente, date('d-m-Y', strtotime($request->fecha) ), $request->desde, $sedes->direccion);
              }
              return response()->json(['success' => 'updated']);
            }else{
              return response()->json(['error'=> 'Ha ocurrido un error']);
            }
        }
      }
      return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy($id){
      $db = DB::connection(CurBD::getCurrentSchema());
      $cita = $db->statement('call OP_Citas_delete_all_Id(?)', array($id));
      return response()->json(['success' => 'deleted']);
    }

    public function sendNotificationEmail($idPaciente, $fecha, $hora_inicio, $direccion){
      $cliente = json_decode(CurBD::getCurrentClienteData());
      $db = DB::connection(CurBD::getCurrentSchema());
      $paciente =  $db->select('call OP_Pacientes_get_all_Id(?)', array($idPaciente));
      $paciente = collect($paciente)[0];
      if ($paciente->email != '') {
        Mail::to($paciente->email)->send(new CitaProgramada($paciente->nombres, $fecha, $hora_inicio, $cliente, $direccion));
      }
    }

}
