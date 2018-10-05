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
        $users = DB::select('call OP_ObtenerUsuarios()'); 
        $users = json_encode($users);

        return view('users.index',compact('users'));
    }

    public function create(){
        return view('users.create');    
    }

    public function show($id){
        $user = DB::select('call OP_ObtenerUsuarios_Id('.$id.')')[0];
        $user = json_encode($user);       
        
        return view('users.show', compact('user'));
    }

    public function edit($id){
        $user = DB::select('call OP_ObtenerUsuarios_Id('.$id.')')[0];
        $user = json_encode($user);       
        
        return view('users.edit', compact('user'));
    }

    public function store(Request $request){
        
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

    public function update(Request $request, $id){
        
    	$validator = Validator::make($request->all(), [
            'name' => 'required|max:120',
            'email' => 'required|max:150|email|unique:users,email,'. $id.',id',
            'password' => 'nullable|min:8|max:150',
            'confirm_password' => 'nullable|max:150|same:password',
            'rolid' => 'required|regex:/(^[1-2]{1}$)/u'
        ]);

    	if ($validator->passes()) {
            try{
                $user = $paciente = User::findOrFail($id);
                $user->name = $request->name;
                $user->email = $request->email;
                $user->rolid = $request->rolid;
                $user->is_active = $request->is_active;
                if(!empty($request->password)) $user->password = Hash::make($request->password);
                $user->save();

                $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Usuario actualizado.']));
                return response()->json(['success' => 'success']);

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $user = User::findOrFail($id);
            $user->is_deleted = true;
            $user->is_active = false;
            $user->save();

            $request->session()->flash('alert', json_encode(['type' => 'success', 'msg' => 'Usuario Eliminado.']));
            return response()->json(['success' => 'success']);

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
