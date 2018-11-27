<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateEgresosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('egresos', function (Blueprint $table) {
            $table->increments('id');
            $table->date('fecha')->nullable();
            $table->integer('cantidad')->nullable();
            $table->string('concepto', 125)->nullable();
            $table->string('tipo', 125)->nullable();
            $table->string('observacion', 125)->nullable();
            $table->decimal('precio_unitario', 10, 2)->nullable();
            $table->integer('doctorId')->nullable();

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
        Schema::dropIfExists('egresos');
    }
}
