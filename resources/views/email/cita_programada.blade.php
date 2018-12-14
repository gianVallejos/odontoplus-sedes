<div>
    <div style="padding: 25px 0; text-align: center; background-color: #f3f3f3;">
        <img src="{{ route("home") }}/images/logotipos/{{ Auth::user()->schema }}_BG_WHITE.png" width="350" alt="{{ $cliente->nombre }}">
    </div>
    <div style="padding: 25px 75px 25px 75px; text-align: left;">
        <div style="font-family:Avenir,Helvetica,sans-serif;font-size:16px;line-height:1.5em; color: #74787e;">
            <p>Hola {{ $nombre_paciente }},</p>
            <p style="margin: 5px 0px;">Tienes una cita programada.</p>
            <p style="margin: 5px 0px;">Fecha: {{ $fecha }}</p>
            <p style="margin: 5px 0px;">Hora: {{ $hora_incio }}</p>
            <p>{{ $cliente->nombre.' - '.$cliente->direccion }}</p>
        </div>
    </div>
    <div style="text-align: center; background-color: #f3f3f3; color: #aeaeae;">
        <div style="font-family:Avenir,Helvetica,sans-serif;padding:30px;color:#aeaeae;font-size:12px">
            © 2018 Odontoplus - Todos los derechos reservados
        </div>
    </div>
</div>
