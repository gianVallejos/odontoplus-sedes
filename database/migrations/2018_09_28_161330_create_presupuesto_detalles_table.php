<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePresupuestoDetallesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('presupuesto_detalles', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('idPresupuesto');
            $table->integer('pieza');
            $table->integer('seccion');
            $table->integer('secUno');
            $table->integer('secDos');
            $table->integer('opcion');
            $table->decimal('monto', 10, 2)->default('0.00');

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
        Schema::dropIfExists('presupuesto_detalles');
    }
}
