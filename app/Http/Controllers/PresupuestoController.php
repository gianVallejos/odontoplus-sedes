<?php

namespace App\Http\Controllers;

use App\Presupuesto;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Validator;

class PresupuestoController extends Controller{    
    private $path = 'presupuestos';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index()
    {
        $data = DB::select('call OP_obtenerPresupuestos()'); 
        $mydata = json_encode($data);
        
        return view($this->path . '.index', compact('mydata'));
    }
    
    public function create()
    {
        $pacientes = DB::select('call OP_obtenerPacientes()');
        $pacientes = json_encode($pacientes);
        $doctores = DB::select('call OP_obtenerDoctores()');
        $doctores = json_encode($doctores);

        return view($this->path . '.create', compact('pacientes', 'doctores'));
    }

    public function store($id)
    {
        //
    }

    public function nuevo($idPaciente, $idDoctor){
        $lastPresupuesto = DB::select('call OP_obtenerUltimoPresupuesto()')[0]->presupuesto; 
        $doctor = DB::select('call OP_obtenerDoctores_presupuesto('. $idDoctor .')')[0];
        $doctor = json_encode($doctor);
        $paciente = DB::select('call OP_obtenerPacientes_presupuesto('. $idPaciente .')')[0];
        $paciente = json_encode($paciente);
        $act_empresa = DB::select('call OP_obtenerEmpresaActual_paciente('. $idPaciente .')')[0]->empresa_id;        
        $precios = DB::select('call OP_obtenerPrecios_EmpresaId('. $act_empresa .')');       
        $precios = json_encode($precios);
        $precios_tabla = DB::select('call OP_obtenerPreciosParaTabla_EmpresaId('. $act_empresa .')');
        $precios_tabla = json_encode($precios_tabla);       

        $fechahora = date('d-m-Y H:i:s');        

        return view($this->path . '.nuevo', compact('lastPresupuesto', 'doctor', 'paciente', 'precios', 'precios_tabla', 'act_empresa', 'fechahora'));
    }

    public function reporte($id){    
        $pres_general = DB::select('call OP_obtenerPresupuesto_Id("'. $id .'")')[0];
        $pres_detalle = DB::select('call OP_obtenerPresupuestoDetalle_Id("'. $id .'")');
        $act_empresa = DB::select('call OP_obtenerEmpresaActual_paciente('. $pres_general->idPaciente .')')[0]->empresa_id; 
        $precios = DB::select('call OP_obtenerPrecios_EmpresaId('. $act_empresa .')');       
        
        $pres_general = json_encode($pres_general);
        $pres_detalle = json_encode($pres_detalle);
        $precios = json_encode($precios);

        $view = view($this->path . '.reporte', compact('pres_general', 'pres_detalle', 'precios'));
        //$pdf = \App::make('dompdf.wrapper');
        //$pdf->setOptions(['isRemoteEnabled' => true, 'isPhpEnabled' => true]);         
        //$pdf->loadHTML($view)->setPaper('a4', 'portrait');
        //return $pdf->stream();
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

    public function destroy(Presupuesto $presupuesto)
    {
        //
    }
}
