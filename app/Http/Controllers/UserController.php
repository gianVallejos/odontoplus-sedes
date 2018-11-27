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
        $users = DB::select('call OP_Usuarios_get_all()'); //Filtrar por Schema
        $users = json_encode($users);

        return view('users.index',compact('users'));
    }

    public function create(){
        return view('users.create');
    }

    public function show($id){
        $user = DB::select('call OP_Usuarios_get_all_id('.$id.')')[0]; //Filtrar por Schema
        $user = json_encode($user);

        return view('users.show', compact('user', 'id'));
    }

    public function edit($id){
        $user = DB::select('call OP_Usuarios_get_all_id('.$id.')')[0]; //Filtrar por Schema
        $user = json_encode($user);

        return view('users.edit', compact('user'));
    }

    public function store(Request $request){

    	$validator = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|email|unique:users|max:255',
            'password' => 'required|min:6|max:50|same:confirm_password',
            'confirm_password' => 'required|same:password|min:6|max:50',
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

                return response()->json(['success' => 'created']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function update(Request $request, $id){

    	$validator = Validator::make($request->all(), [
            'name' => 'required|max:255',
            'email' => 'required|max:255|email|unique:users,email,'. $id.',id',
            'password' => 'nullable|min:6|max:50|same:confirm_password',
            'confirm_password' => 'same:password|nullable|min:6|max:50|',
            'rolid' => 'required|regex:/(^[1-2]{1}$)/u'
        ]);

    	if ($validator->passes()) {
            try{
                $user = $paciente = User::findOrFail($id);
                $user->name = $request->name;
                $user->email = $request->email;
                $user->rolid = $request->rolid;
                $user->is_active = $request->is_active;
                if( !empty($request->password) && !empty($request->confirm_password) ){
                    $user->password = Hash::make($request->password);
                }
                $user->save();

                return response()->json(['success' => 'updated']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $user = User::findOrFail($id);
            $user->is_active = !$request->is_active;
            $user->save();

            return response()->json(['success' => 'deleted']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
