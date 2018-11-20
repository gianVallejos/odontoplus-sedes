<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProveedorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('proveedors', function (Blueprint $table) {
            $table->increments('id');
            $table->string('nombres', 120);
            $table->string('email', 120)->nullable();
            $table->string('direccion', 100);
            $table->string('dni', 8);
            $table->string('telefono', 60)->nullable();
            $table->string('celular', 60)->nullable();
            $table->string('empresa', 120)->nullable();
            $table->string('ciudad', 100)->nullable();
            $table->string('ruc', 11)->nullable();
            $table->string('banco', 60)->nullable();
            $table->string('nrocuenta', 60)->nullable();
            $table->integer('insumo_id');
            $table->integer('tipo_id');

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
        Schema::dropIfExists('proveedors');
    }
}
