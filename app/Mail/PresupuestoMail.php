<?php
 
namespace App\Mail;
 
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;
 
class PresupuestoMail extends Mailable
{
    use Queueable, SerializesModels;
     
    public $presupuesto;

    public function __construct($presupuesto)
    {
        $this->presupuesto = $presupuesto;
    }
 
    public function build()
    {
        return $this->view('email.presupuesto');
    }
}