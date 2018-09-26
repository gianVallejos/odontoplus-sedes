<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;

class UserController extends Controller{

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
          $users = User::all();

          $users = DB::table('users')
          ->join('roles', 'users.rolid', '=', 'roles.id')
          ->get();

          return view('users.index',compact('users'));
    }
}
