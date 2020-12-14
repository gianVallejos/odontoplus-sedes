<?php

namespace App\Http\Controllers;

use App\Presupuesto;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Validator;

class PresupuestoController extends Controller{
    private $path = 'presupuestos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $presupuesto =  $db->select('call OP_Presupuestos_get_all()');
      $mydata = json_encode(collect($presupuesto));

      return view($this->path . '.index', compact('mydata'));
    }

    public function create(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $pacientes =  $db->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode(collect($pacientes));
      $doctores =  $db->select('call OP_Doctors_get_all()');
      $doctores = json_encode(collect($doctores));

      return view($this->path . '.create', compact('pacientes', 'doctores'));
    }

    public function store(Request $request){
        $idPaciente = $request->pacienteId;
        $idDoctor = $request->doctorId;
        $nroPresupuesto = $request->nroPresupuesto;
        $descuento = $request->descuento;
        $tratamientos = $request->tratamientos;

        DB::beginTransaction();
        $db = DB::connection(CurBD::getCurrentSchema());
        $res_general =  $db->select('call OP_Presupuestos_add_all(?,?,?,?)', 
                                     array($nroPresupuesto, $idPaciente, $idDoctor, $descuento)
                                   );
        $res_general = collect($res_general);
        foreach( $tratamientos as $rt ){
            $sec1 = ( isset($rt['secUno']) ) ? $rt['secUno'] : '0';
            $sec2 = ( isset($rt['secDos']) ) ? $rt['secDos'] : '0';
            $pza = ( isset($rt['pieza']) ? $rt['pieza'] : '0' );
            $res_detalle =  $db->select('call OP_Presupuesto_Detalles_add_all(?,?,?,?,?,?,?)', 
                                              array($nroPresupuesto, $pza, $rt['seccion'], $sec1, $sec2, $rt['opcion'], $rt['monto'])
                                        );
            $res_detalle = collect($res_detalle);
        }

        $resg = $res_general[0]->ESTADO;
        $resd = $res_detalle[0]->ESTADO;
        if( $resg == 0 || $resd == 0 ){
            DB::rollback();
            return 'error';
        }

        DB::commit();
        return 'ok';
    }

    public function nuevo($idPaciente, $idDoctor){
      $db = DB::connection(CurBD::getCurrentSchema());
      
      $lastPresupuesto =  $db->select('call OP_Presupuestos_get_last_Id()');
      $lastPresupuesto = collect($lastPresupuesto)[0]->presupuesto;
      $doctor =  $db->select('call OP_Presupuestos_get_doctores(?)', array($idDoctor));
      $doctor = json_encode(collect($doctor)[0]);
      $paciente =  $db->select('call OP_Presupuestos_get_pacientes(?)', array($idPaciente));
      $paciente = json_encode(collect($paciente)[0]);
      $act_empresa =  $db->select('call OP_Pacientes_get_empresa_Id(?)', array($idPaciente));
      $act_empresa = collect($act_empresa)[0]->empresa_id;
      $precios =  $db->select('call OP_Precios_get_all_by_empresa_Id(?)', array($act_empresa));
      $precios = json_encode(collect($precios));
      $precios_tabla =  $db->select('call OP_Precios_get_all_for_table_by_empresa_Id(?)', array($act_empresa));
      $precios_tabla = json_encode(collect($precios_tabla));

      $fechahora = date('d-m-Y H:i:s');

      return view($this->path . '.nuevo', compact('lastPresupuesto', 'doctor', 'paciente', 'precios', 'precios_tabla', 'act_empresa', 'fechahora'));
    }

    public function reporte($id){
      $db = DB::connection(CurBD::getCurrentSchema());

      $pres_general =  $db->select('call OP_Presupuestos_get_by_Id(?)', array($id));
      $pres_general = collect($pres_general)[0];
      $idPaciente = $pres_general->idPaciente;
      $pres_general = json_encode($pres_general);      

      $pres_detalle =  $db->select('call OP_Presupuesto_Detalles_by_Id(?)', array($id));
      $pres_detalle = json_encode(collect($pres_detalle));

      $act_empresa =  $db->select('call OP_Pacientes_get_empresa_Id(?)', array($idPaciente));
      $act_empresa = collect($act_empresa)[0]->empresa_id;      
      $precios =  $db->select('call OP_Precios_get_all_by_empresa_Id(?)', array($act_empresa));
      $precios = json_encode(collect($precios));

      $paciente_sede =  $db->select('call OP_Sedes_get_all_by_paciente_id(?)', array($idPaciente));    
      $paciente_sede = json_encode(collect($paciente_sede)[0]);

      $view = view($this->path . '.reporte', compact('pres_general', 'pres_detalle', 'precios', 'paciente_sede'));

      return $view;
    }

    public function show(Presupuesto $presupuesto)
    {

    }

    public function edit(Presupuesto $presupuesto)
    {
        //
    }

    public function update($id, Presupuesto $presupuesto)
    {
        //
    }

    public function destroy(Request $request, $id)
    {
      try{
        $db = DB::connection(CurBD::getCurrentSchema());
        $res =  $db->statement('call OP_Presupuestos_delete_all_Id(?)', array($id));
        return response()->json(['success' => 'deleted']);
      }catch(Exception $e){
        return response()->json(['error'=>$e->getMessage()]);
      }
    }
}
