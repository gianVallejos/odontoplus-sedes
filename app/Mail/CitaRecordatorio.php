<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class CitaRecordatorio extends Mailable
{
    use Queueable, SerializesModels;
    public $nombre_paciente;
    public $doctor;
    public $fecha;
    public $hora_inicio;
    public $schema;
    public $cliente;

    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($schema, $cliente, $nombre_paciente, $fecha, $hora_inicio){
        $this->schema = $schema;
        $this->cliente = $cliente;
        $this->nombre_paciente = $nombre_paciente;
        $this->fecha = $fecha;
        $this->hora_inicio = $hora_inicio;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        return $this->view('email.cita_recordatorio');
    }
}
