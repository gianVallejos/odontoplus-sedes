<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateIngresosDetallesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ingresos_detalles', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('ingresoId')->nullable();
            $table->integer('precioId')->nullable();
            $table->integer('cantidad')->nullable();
            $table->decimal('monto', 11, 2)->nullable();
            $table->date('fecha')->nullable();
            $table->integer('doctorId')->nullable();
            $table->decimal('margen_ganancia', 10, 0)->nullable();
            
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
        Schema::dropIfExists('ingresos_detalles');
    }
}
