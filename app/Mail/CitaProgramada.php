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
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($nombre_paciente, $doctor, $fecha, $hora_incio){
        $this->nombre_paciente = $nombre_paciente;
        $this->doctor = $doctor;
        $this->fecha = $fecha;
        $this->hora_incio = $hora_incio;
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
