<?php

namespace App\Http\Controllers;

use App\Paciente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PacienteController extends Controller
{
    private $path = 'pacientes';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index()
    {
        $data = DB::select('call OP_obtenerPacientes()'); 
        $data = json_encode($data);
        return view($this->path.'.index', compact('data'));
    }

    public function create()
    {
        $empresas = DB::select('call OP_obtenerEmpresasJson()');
        $empresas = json_encode($empresas);
        return view($this->path . '.create', compact('empresas'));    
    }

    public function store(Request $request)
    {
        //
    }

    public function show($id)
    {
        print $id;
        //return view($this->path . '.show', compact('id'));
    }

    public function edit(Paciente $paciente)
    {
        //
    }

    public function update(Request $request, Paciente $paciente)
    {
        //
    }

    public function destroy(Paciente $paciente)
    {
        //
    }
}
