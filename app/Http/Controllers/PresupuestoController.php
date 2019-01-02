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
        $presupuesto =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_get_all()');
        $mydata = json_encode($presupuesto);

        return view($this->path . '.index', compact('mydata'));
    }

    public function create(){
        $pacientes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
        $pacientes = json_encode($pacientes);
        $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
        $doctores = json_encode($doctores);

        return view($this->path . '.create', compact('pacientes', 'doctores'));
    }

    public function store(Request $request){
        $idPaciente = $request->pacienteId;
        $idDoctor = $request->doctorId;
        $nroPresupuesto = $request->nroPresupuesto;
        $descuento = $request->descuento;
        $tratamientos = $request->tratamientos;

        DB::beginTransaction();

        $res_general =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_add_all('. $nroPresupuesto .', '. $idPaciente .', ' . $idDoctor .', ' . $descuento . ')');
        foreach( $tratamientos as $rt ){
            $sec1 = ( isset($rt['secUno']) ) ? $rt['secUno'] : '0';
            $sec2 = ( isset($rt['secDos']) ) ? $rt['secDos'] : '0';
            $pza = ( isset($rt['pieza']) ? $rt['pieza'] : '0' );
            $res_detalle =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuesto_Detalles_add_all('. $nroPresupuesto .', ' . $pza . ', ' . $rt['seccion'] . ', ' . $sec1 . ', ' . $sec2 .', '. $rt['opcion'] .', '. $rt['monto'] .')');
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
        $lastPresupuesto =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_get_last_Id()')[0]->presupuesto;
        $doctor =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_get_doctores('. $idDoctor .')')[0];
        $doctor = json_encode($doctor);
        $paciente =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_get_pacientes('. $idPaciente .')')[0];
        $paciente = json_encode($paciente);
        $act_empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_empresa_Id('. $idPaciente .')')[0]->empresa_id;
        $precios =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Precios_get_all_by_empresa_Id('. $act_empresa .')');
        $precios = json_encode($precios);
        $precios_tabla =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Precios_get_all_for_table_by_empresa_Id('. $act_empresa .')');
        $precios_tabla = json_encode($precios_tabla);

        $fechahora = date('d-m-Y H:i:s');

        return view($this->path . '.nuevo', compact('lastPresupuesto', 'doctor', 'paciente', 'precios', 'precios_tabla', 'act_empresa', 'fechahora'));
    }

    public function reporte($id){
        $pres_general =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_get_by_Id("'. $id .'")')[0];
        $pres_detalle =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuesto_Detalles_by_Id("'. $id .'")');
        $act_empresa =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_empresa_Id('. $pres_general->idPaciente .')')[0]->empresa_id;
        $precios =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Precios_get_all_by_empresa_Id('. $act_empresa .')');

        $pres_general = json_encode($pres_general);
        $pres_detalle = json_encode($pres_detalle);
        $precios = json_encode($precios);

        $cliente = CurBD::getCurrentClienteData();

        $view = view($this->path . '.reporte', compact('pres_general', 'pres_detalle', 'precios', 'cliente'));

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
            $res =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Presupuestos_delete_all_Id('. $id .')');

            return response()->json(['success' => 'deleted']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
