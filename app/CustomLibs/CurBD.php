<?php

namespace App\CustomLibs;

class CurBD{
    public static function getCurrentSchema(){
        $schema_name = \Auth::user()->schema;
        return $schema_name;
    }
}

 ?>
