<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\Paciente;
use Validator;

class WsOdontoplusController extends Controller
{
    function OP_obtenerPacientes(){
    	$data = DB::select('call OP_obtenerPacientes()'); 
        $data = json_encode($data);
        return $data;
    }

    function OP_crearPaciente(Request $request){
    	$validator = Validator::make($request->all(), [
            'nombres' => 'required|string',
            'apellidos' => 'required|string',
            'dni' => 'required|digits:8',
            'direccion' => 'required|string',
            'email' => 'nullable|email',

        ]);

    	if ($validator->passes()) {
    			$paciente = new Paciente();
                $paciente->nombres = $request->nombres;
                $paciente->apellidos = $request->apellidos;
                $paciente->dni = $request->dni;
                $paciente->email = $request->email;
                $paciente->direccion = $request->direccion;
                $paciente->fechanacimiento = $request->fechanacimiento;
                $paciente->genero = $request->genero;
                $paciente->estado = $request->estado;
                $paciente->telefono = $request->telefono;
                $paciente->fax = $request->fax;
                $paciente->celular = $request->celular;
                $paciente->celular_aux = $request->celular_aux;
                $paciente->empresa_id = $request->empresa_id;
                $paciente->seguro_ind = $request->seguro_ind;
                $paciente->nombre_apoderado = $request->nombre_apoderado;
                $paciente->celular_apoderado = $request->celular_apoderado;

                $paciente->save();

    		return response()->json(['success' => 'success']);
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    function OP_obtenerPacientes_Id($id){        
        $data = DB::select('call OP_obtenerPacientes_Id('. $id .')')[0];
        $data = json_encode($data);
        print $data;
        //return response()->json(['form' => $data]);
    }

    function OP_actualizarPaciente_Id(Request $request, $id){
        $validator = Validator::make($request->all(), [
            'nombres' => 'required|string',
            'apellidos' => 'required|string',
            'dni' => 'required|digits:8',
            'direccion' => 'required|string',
            'email' => 'nullable|email',

        ]);

        if ($validator->passes()) {
                $paciente = Paciente::findOrFail($id);
                $paciente->nombres = $request->nombres;
                $paciente->apellidos = $request->apellidos;
                $paciente->dni = $request->dni;
                $paciente->email = $request->email;
                $paciente->direccion = $request->direccion;
                $paciente->fechanacimiento = $request->fechanacimiento;
                $paciente->genero = $request->genero;
                $paciente->estado = $request->estado;
                $paciente->telefono = $request->telefono;
                $paciente->fax = $request->fax;
                $paciente->celular = $request->celular;
                $paciente->celular_aux = $request->celular_aux;
                $paciente->empresa_id = $request->empresa_id;
                $paciente->seguro_ind = $request->seguro_ind;
                $paciente->nombre_apoderado = $request->nombre_apoderado;
                $paciente->celular_apoderado = $request->celular_apoderado;

                $paciente->save();

            return response()->json(['success' => 'success']);
        }
        return response()->json(['error'=>$validator->errors()]);
    }

    function OP_eliminarPaciente_Id($id){
        $paciente = Paciente::findOrFail($id);
        $paciente->isDeleted = true;
        $paciente->save();

        return response()->json(['success' => 'success']);
    }

    function OP_saveNuevoPresupuesto(Request $request){  
        $idPaciente = $request->pacienteId;
        $idDoctor = $request->doctorId;
        $nroPresupuesto = $request->nroPresupuesto;
        $descuento = $request->descuento;
        $tratamientos = $request->tratamientos;

        $res_general = DB::select('call OP_agregarPresupuestoGeneral('. $nroPresupuesto .', '. $idPaciente .', ' . $idDoctor .', ' . $descuento . ')');        
        foreach( $tratamientos as $rt ){
            $sec1 = ( isset($rt['secUno']) ) ? $rt['secUno'] : '0';
            $sec2 = ( isset($rt['secDos']) ) ? $rt['secDos'] : '0';
            $pza = ( isset($rt['pieza']) ? $rt['pieza'] : '0' );            
            $res_detalle = DB::select('call OP_agregarPresupuestosDetalles('. $nroPresupuesto .', ' . $pza . ', ' . $rt['seccion'] . ', ' . $sec1 . ', ' . $sec2 .', '. $rt['opcion'] .')');
        }

        $resg = $res_general[0]->ESTADO;
        $resd = $res_detalle[0]->ESTADO;
        if( $resg == 0 || $resd == 0 ){
            return 'error';
        }

        return 'ok';
    }
}
