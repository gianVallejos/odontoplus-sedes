<?php

namespace App\Http\Controllers;

use App\Paciente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Validator;

class PacienteController extends Controller
{
    private $path = 'pacientes';
    public function __construct(){
        $this->middleware('auth');
    }

    public function index()
    {
        //$data = DB::select('call OP_obtenerPacientes()'); 
        //$data = json_encode($data);
        
        //print $data;
        //return view($this->path.'.index', compact('data'));
        return view($this->path .'.index');
    }

    public function create()
    {
        $empresas = DB::select('call OP_obtenerEmpresasJson()');
        $empresas = json_encode($empresas);
        return view($this->path . '.create', compact('empresas'));    
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'nombres' => 'required|string',
            'apellidos' => 'required|string',
            'dni' => 'required|digits:8'
        ]);

        if ($validator->passes()) {
            print 'Passed';
        }
        
        return response()->json(['error'=>$validator->errors()]);        
    }

    public function show($id, $flag)
    {        
        $empresas = DB::select('call OP_obtenerEmpresasJson()');
        $empresas = json_encode($empresas);
        return view($this->path . '.show', compact('id', 'empresas', 'flag'));
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
