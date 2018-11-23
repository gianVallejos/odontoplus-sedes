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
      $pacientes = DB::select('call OP_obtenerPacientes()');
      $pacientes = json_encode($pacientes);

        return view('home', compact('pacientes'));
    }

    public function containerGeneral(){
        return view('container-general');
    }
}
