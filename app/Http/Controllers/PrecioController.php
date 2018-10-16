<?php

namespace App\Http\Controllers;

use App\Precio;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class PrecioController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $treatments = DB::select('call OP_ObtenerTratamientos()'); 
        $companies = DB::select('call OP_ObtenerEmpresas()');
        $prices = DB::select('call OP_ObtenerPreciosEstandard()');
        $treatments = json_encode($treatments);
        $companies = json_encode($companies);
        $prices = json_encode($prices);

        return view('precios.index',compact('treatments', 'companies', 'prices'));     
    }
}
