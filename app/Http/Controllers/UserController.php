<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class UserController extends Controller{

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $users = User::all();
        $users = DB::select('call OP_ObtenerUsuarios()'); 
        $users = json_encode($users);

        return view('users.index',compact('users'));
    }

    public function create(){
        return view('users.create');    
    }

}
