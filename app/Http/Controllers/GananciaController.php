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
      $sedes = DB::connection(CurBD::getCurrentSchema())->select('call OP_Sedes_get_all()');
      $sedes = json_encode($sedes);
      return view('ganancias.index', compact('sedes'));
    }

    // gananciasFechas se usa en ganancias reporte como PDF
    public function gananciasFechas($start, $end, $sedeId){
        $ingresos = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ganancias_sede_fechas('. $sedeId .',"'. $start .'","'. $end .'")');
        $totales = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_totales_doctor_id_fechas("0","'. $start .'","'. $end .'")');
        $ingresos = json_encode($ingresos);
        $igeneral = json_encode(['totales' => $totales[0], 'fechaInicial' => $start, 'fechaFinal' => $end]);
        $cliente = CurBD::getCurrentClienteData();
        return view('ganancias.ganancias_reporte', compact('ingresos', 'igeneral', 'cliente'));
    }
    public function gananciasFechasJSON($start, $end, $sedeId){
        $ingresos = DB::connection(CurBD::getCurrentSchema())->select('call OP_Ingresos_get_ganancias_sede_fechas('. $sedeId .',"'. $start .'","'. $end .'")');
        $ingresos = json_encode($ingresos);
        return response()->json(['ingresos' => $ingresos]);
    }
}
