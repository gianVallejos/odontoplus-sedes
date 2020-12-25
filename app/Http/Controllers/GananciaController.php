<?php

namespace App\Http\Controllers;
use App\CustomLibs\CurBD;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GananciaController extends Controller{
    public function __construct(){
      $this->middleware('auth');
    }

    public function index(){
      $db = DB::connection(CurBD::getCurrentSchema());
      $sedes = $db->select('call OP_Sedes_get_all()');
      $sedes = json_encode(collect($sedes));
      return view('ganancias.index', compact('sedes'));
    }

    public function gananciasFechasJSON($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $ingresos = $db->select('call OP_Ingresos_get_ganancias_sede_fechas('. $sedeId .',"'. $start .'","'. $end .'")');
      $ingresos = json_encode(collect($ingresos));
      return response()->json(['ingresos' => $ingresos]);
    }

    public function reporte($start, $end, $sedeId){
      $db = DB::connection(CurBD::getCurrentSchema());
      $ingresos = $db->select('call OP_Ingresos_get_ganancias_sede_fechas('. $sedeId .',"'. $start .'","'. $end .'")');
      $ingresos = collect($ingresos);
      $totales = $db->select('call OP_Ingresos_get_totales_doctor_id_fechas("0",'.$sedeId.',"'. $start .'","'. $end .'")');
      $totales = collect($totales)[0];
      $igeneral = json_encode(['totales' => $totales, 'fechaInicial' => $start, 'fechaFinal' => $end]);
      $cliente = CurBD::getCurrentClienteData();
      return view('ganancias.ganancias_reporte', compact('ingresos', 'igeneral', 'cliente'));
    }
}
