<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
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
      $pacientes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_for_search()');
      $pacientes = json_encode($pacientes);
      $sedes = null;
        if (\Auth::user()->rolid == 3) {  
            $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all_id('.CurBD::getCurrentSede().')');
        }else {
            $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
        }
        $is_admin_sede = \Auth::user()->rolid == 3 ? json_encode(true) : json_encode(false);
        $sedes = json_encode($sedes);

      return view('home', compact('pacientes', 'sedes','is_admin_sede'));
    }
}
