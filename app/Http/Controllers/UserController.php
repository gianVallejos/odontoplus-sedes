<?php

namespace App\Http\Controllers;

use App\User;
use Illuminate\Http\Request;
use App\CustomLibs\CurBD;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller{

    public function __construct(){
        $this->middleware('auth');
    }

    public function index(){
        $users = DB::select('call OP_Usuarios_get_all("'. CurBD::getCurrentSchema() .'")'); //Filtrar por Schema
        $users = json_encode($users);

        return view('users.index',compact('users'));
    }

    public function create(){
        return view('users.create');
    }

    public function show($id){
        $user = DB::select('call OP_Usuarios_get_all_id('.$id.', "'. CurBD::getCurrentSchema() . '")')[0]; //Filtrar por Schema
        $user = json_encode($user);

        return view('users.show', compact('user', 'id'));
    }

    public function edit($id){
        $user = DB::select('call OP_Usuarios_get_all_id('.$id.', "'. CurBD::getCurrentSchema() .'")')[0]; //Filtrar por Schema
        $user = json_encode($user);

        return view('users.edit', compact('user'));
    }

    public function store(Request $request){

    	$validator = Validator::make($request->all(), [
            'name' => 'required|alpha|max:255',
            'email' => 'required|email|unique:users|max:255',
            'password' => 'required|min:6|max:50|same:confirm_password',
            'confirm_password' => 'required|same:password|min:6|max:50',
            'rolid' => 'required|integer',
            'is_active' => 'required'
        ]);

    	if ($validator->passes()) {

            try{
                $is_active = ($request->is_active == null) ? 0 : 1;
                $user = DB::select('call OP_Usuarios_add_all("'. $request->name .'", "'. $request->email
                                                              .'", "'. Hash::make($request->password) .'", '. $request->rolid
                                                              .', '. $is_active .', "'. CurBD::getCurrentSchema() .'", '. CurBD::getCurrentClienteId() .')');

                if( $user[0]->ESTADO > 0 ){
                    return response()->json(['success' => 'created']);
                }else{
                    return response()->json(['error' => 'Ha ocurrido un error']);
                }

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
                $is_active = ($request->is_active == null) ? 0 : 1;
                if( !empty($request->password) && !empty($request->confirm_password) ){
                    $user = DB::select('call OP_Usuarios_update_all("'. $request->name .'", "'. $request->email
                                                                      .'", "'. Hash::make($request->password) .'", '. $request->rolid
                                                                      .', '. $is_active .', '. $id .', "'. CurBD::getCurrentSchema() .'", '. CurBD::getCurrentClienteId() .')');
                }else{
                    $user = DB::select('call OP_Usuarios_update_no_pass("'. $request->name .'", "'. $request->email
                                                                          .'", '. $request->rolid .', '. $is_active .', '. $id .', "'. CurBD::getCurrentSchema() .'", '. CurBD::getCurrentClienteId() .')');
                }

                if( $user[0]->ESTADO > 0 ){
                    return response()->json(['success' => 'updated']);
                }else{
                    return response()->json(['error' => 'Ha ocurrido un error']);
                }

            }catch(Exception $e){
                return response()->json(['error'=>$e->getMessage()]);
            }
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    public function destroy(Request $request, $id){
        try{
            $aux = ($request->is_active == 1 ) ? 0 : 1;
            $user = DB::select('call OP_Usuarios_delete_all('. $id .', "'. CurBD::getCurrentSchema() .'", '. $aux .')');
            if( $user[0]->ESTADO > 0 ){
                return response()->json(['success' => 'deleted']);
            }else{
                return response()->json(['error' => 'Ha ocurrido un error']);
            }

        }catch(Exception $e){
            return response()->json(['error'=>$e->getMessage()]);
        }
    }
}
