<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Crypt;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Contracts\Encryption\DecryptException;

class PublicController extends Controller{
    private $path = 'presupuestos';

    public function showPrespuesto($dataBaseCryp,$presupuestoId){
        $id = $this->getDatabaseString(Crypt::decryptString($presupuestoId));
        $squema = $this->getDatabaseString(Crypt::decryptString($dataBaseCryp));
        $pres_general =  DB::connection($squema)->select('call OP_Presupuestos_get_by_Id("'. $id .'")')[0];
        $pres_detalle =  DB::connection($squema)->select('call OP_Presupuesto_Detalles_by_Id("'. $id .'")');
        $act_empresa =  DB::connection($squema)->select('call OP_Pacientes_get_empresa_Id('. $pres_general->idPaciente .')')[0]->empresa_id;
        $precios =  DB::connection($squema)->select('call OP_Precios_get_all_by_empresa_Id('. $act_empresa .')');
        $paciente_sede =  DB::connection($squema)->select('call OP_Sedes_get_all_by_paciente_id("'. $pres_general->idPaciente .'")')[0];

        $pres_general = json_encode($pres_general);
        $pres_detalle = json_encode($pres_detalle);
        $precios = json_encode($precios);
        $paciente_sede = json_encode($paciente_sede);
        $es_reporte = false;
        $es_reporte = json_encode($es_reporte);

        $view = view($this->path . '.reporte', compact('pres_general', 'pres_detalle', 'precios', 'paciente_sede','es_reporte'));

        return $view;
    }

    private function getDatabaseString($cadena){
        $array = explode('"',$cadena,3);
        return $array[1];
    }
}