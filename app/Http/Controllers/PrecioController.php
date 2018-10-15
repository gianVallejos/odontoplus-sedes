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
        $prices = DB::select('call OP_ObtenerPrecios()'); 
        $prices = json_encode($prices);

        return view('precios.index',compact('prices'));
    }
}
