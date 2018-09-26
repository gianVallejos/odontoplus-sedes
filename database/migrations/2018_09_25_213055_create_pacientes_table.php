<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePacientesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pacientes', function (Blueprint $table) {
            $table->increments('id');
            $table->string('nombres', 120);
            $table->string('apellidos', 120);
            $table->string('dni', 8);
            $table->string('email', 120);
            $table->string('direccion', 120);
            $table->date('fechanacimiento');
            $table->string('genero', 25);
            $table->string('estado', 25);
            $table->string('telefono', 50);
            $table->string('fax', 50);
            $table->string('celular', 50);
            $table->string('celular_aux', 50);
            $table->integer('empresa_id');
            $table->integer('seguro_ind');
            $table->string('nombre_apoderado', 120);
            $table->string('celular_apoderado', 50);

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pacientes');
    }
}
