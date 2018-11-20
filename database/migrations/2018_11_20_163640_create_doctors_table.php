<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDoctorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('doctors', function (Blueprint $table) {
            $table->increments('id');
            $table->string('nombres', 120);
            $table->string('apellidos', 120);
            $table->string('dni', 8);
            $table->string('email', 120)->nullable();
            $table->string('direccion', 120)->nullable();
            $table->date('fechanacimiento')->nullable();
            $table->string('genero', 25)->nullable();
            $table->string('estado', 25)->nullable();
            $table->string('telefono', 50)->nullable();
            $table->string('celular', 50)->nullable();
            $table->string('celular_aux', 50)->nullable();
            $table->decimal('margen_ganancia', 10, 0)->nullable()->default(0);

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
        Schema::dropIfExists('doctors');
    }
}
