<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class DoctorController extends Controller{
    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $doctors = DB::select('call OP_ObtenerDoctores()'); 
        $doctors = json_encode($doctors);

        return view('doctors.index',compact('doctors'));
    }

    public function create(){
        return view('doctors.new');    
    }

    public function show($id){
        $doctor = DB::select('call OP_ObtenerDoctores_Id('.$id.')')[0];
        $doctor = json_encode($doctor);       
        
        return view('doctors.show', compact('doctor'));
    }

    public function edit($id){
        $doctor = DB::select('call OP_ObtenerDoctores_Id('.$id.')')[0];
        $doctor = json_encode($doctor);       
        
        return view('doctors.edit', compact('doctor'));
    }

}
