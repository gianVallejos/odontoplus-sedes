<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

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

    function store(Request $request){
        
    	$validator = Validator::make($request->all(), [
            'name' => 'required|max:120',
            'email' => 'required|unique:users|max:150',
            'password' => 'required|min:8|max:150',
            'confirm_password' => 'required|max:150|same:password',
            'rolid' => 'required|regex:/(^[1-2]{1}$)/u',
            'is_active' => 'required'
        ]);


    	if ($validator->passes()) {

            try{
                $user = new User();
                $user->name = $request->name;
                $user->email = $request->email;
                $user->password = Hash::make($request->password);
                $user->rolid = $request->rolid;
                $user->is_active = $request->is_active;
                $user->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'User was successful added!']));
                    
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

}
