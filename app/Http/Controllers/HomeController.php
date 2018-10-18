<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HomeController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void
     */
    
    public function __construct()
    {
        $this->middleware('auth');
    }

    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $last_pacientes = DB::select('call OP_obtenerUltimosDiezPacientes()');
        $last_pacientes = json_encode($last_pacientes);

        $last_presupuestos = DB::select('call OP_obtenerUltimosDiezPresupuestos()');
        $last_presupuestos = json_encode($last_presupuestos);
        
        return view('home', compact('last_pacientes', 'last_presupuestos'));
    }

    public function containerGeneral(){
        return view('container-general');
    }
}
