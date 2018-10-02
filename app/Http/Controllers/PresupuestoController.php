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
        return view($this->path . '.index');
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
        return view($this->path . '.nuevo', compact('idPaciente', 'idDoctor', 'lastPresupuesto'));
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
