<?php
		$cur_schema = \App\CustomLibs\CurBD::getCurrentSchema();
    $url = 'https://app.odontoplus.pe/images/logotipos/' . $cur_schema . '_BG_WHITE.png';
    $error_url = 'https://app.odontoplus.pe/images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png';
 ?>
<div>
    <div style="padding: 25px 0; text-align: center; background-color: #f3f3f3;">
        <img src="<?php echo $url; ?>" alt="{{ $cliente->nombre }}" onerror="<?php echo $error_url; ?>">
    </div>
    <div style="text-align: center; margin-top: 45px; margin-bottom: 45px;">
      <div style="display: inline-block; width: 570px;">
        <h1 style="font-family:Avenir,Helvetica,sans-serif;box-sizing:border-box;color:#2f3133;font-size:19px;font-weight:bold;margin-top:0;text-align:left">
          {{ $nombre_paciente}}, ¡Tienes una cita!
        </h1>
        <p style="font-family:Avenir,Helvetica,sans-serif;box-sizing:border-box;color:#74787e;font-size:16px;line-height:1.5em;margin-top:0;text-align:left">
          Tu cita ha sido programada para el día {{ $fecha }} a las {{$hora_inicio }}.
          <br />Te esperamos en la sede de {{ $cliente->nombre }} ubicada en {{ $direccion }}.
        </p>
      </div>
    </div>
    <div style="text-align: center; background-color: #f3f3f3; color: #aeaeae;">
        <div style="font-family:Avenir,Helvetica,sans-serif;padding:30px;color:#aeaeae;font-size:12px">
            © 2018 Odontoplus - Todos los derechos reservados
        </div>
    </div>
</div>
