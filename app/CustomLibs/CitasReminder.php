<?php

namespace App\CustomLibs;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Mail;
use App\Mail\CitaRecordatorio;

class CitasReminder{
    private static $schemas = [
        '1_ODONTOPLUS_CAJ'
    ];

    public static function sendEmails(){
        foreach (self::$schemas as $schema) {  
            $cliente = DB::select('call OP_Clientes_get_all_bySchema("'. $schema .'")')[0];     
            $citas = DB::connection($schema)->select('call OP_Citas_get_all_of_next_day()');   

            foreach ($citas as $cita) {
                if ($cita->paciente_email != '') {
                    Mail::to($cita->paciente_email)->send(new CitaRecordatorio($schema, $cliente, $cita->paciente_nombre, $cita->fecha, $cita->hr_inicio));
                }
            }
        }
    }
}

?>