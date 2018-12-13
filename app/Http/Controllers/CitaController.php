<?php

namespace App\Http\Controllers;
use App\CustomLibs\CurBD;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CitaController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all()');
        return view('citas.index', compact('cita'));
    }

    public function create(){
      $pacientes =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Pacientes_get_all()');
      $pacientes = json_encode($pacientes);
      $doctores =  DB::connection(CurBD::getCurrentSchema())->select('call OP_Doctors_get_all()');
      $doctores = json_encode($doctores);

      return view('citas.create', compact('pacientes', 'doctores'));
    }

    public function show($id){
        $data = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_get_all_id('.$id.')')[0];
        return response()->json(['data' => $data ]);
    }

    public function store(Request $request){
    	$validator = Validator::make($request->all(), [
            'title' => 'required|string|max:200',
        ]);

    	if ($validator->passes()) {
            $cita = DB::connection(CurBD::getCurrentSchema())->select('call OP_Citas_add_all("'.$request->title.'")');
        }
        return response()->json(['error'=>$validator->errors()]);
    }

}
