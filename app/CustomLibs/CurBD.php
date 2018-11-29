<?php

namespace App\CustomLibs;

use Illuminate\Support\Facades\DB;
class CurBD{
    public static function getCurrentSchema(){
        $schema_name = \Auth::user()->schema;
        return $schema_name;
    }
    public static function getCurrentClienteId(){
        return \Auth::user()->clienteId;
    }

    public static function getCurrentClienteData(){
        $cliente = DB::select('call OP_Clientes_get_all_byUserId('. \Auth::user()->clienteId .')')[0];
        return json_encode($cliente);
    }
}

 ?>
