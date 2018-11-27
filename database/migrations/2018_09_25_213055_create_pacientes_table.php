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
            $table->string('email', 120)->nullable();
            $table->string('direccion', 120);
            $table->date('fechanacimiento')->nullable();
            $table->string('genero', 25)->nullable();
            $table->string('estado', 25)->nullable();
            $table->string('telefono', 50)->nullable();
            $table->string('fax', 50)->nullable();
            $table->string('celular', 50)->nullable();
            $table->string('celular_aux', 50)->nullable();
            $table->integer('empresa_id');
            $table->integer('seguro_ind')->nullable();
            $table->string('nombre_apoderado', 150)->nullable();
            $table->string('celular_apoderado', 150)->nullable();
            $table->integer('referencia_id')->nullable();

            $table->boolean('is_deleted')->default(false);

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
