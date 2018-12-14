<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class CitaProgramada extends Mailable
{
    use Queueable, SerializesModels;
    public $nombre_paciente;
    public $doctor;
    public $fecha;
    public $hora_incio;
    public $cliente;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($nombre_paciente, $doctor, $fecha, $hora_incio, $cliente){
        $this->nombre_paciente = $nombre_paciente;
        $this->doctor = $doctor;
        $this->fecha = $fecha;
        $this->hora_incio = $hora_incio;
        $this->cliente = $cliente;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('email.cita_programada');
    }
}
