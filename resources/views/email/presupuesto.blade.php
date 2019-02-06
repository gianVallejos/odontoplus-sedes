<?php
	$cur_schema = \App\CustomLibs\CurBD::getCurrentSchema();
    $url_img = 'https://atet.odontoplus.pe/images/logotipos/' . $cur_schema . '_BG_WHITE.png';
    $error_url = 'https://atet.odontoplus.pe/images/logotipos/1_ODONTOPLUS_CAJ_BG_WHITE.png';
 ?>
<div style="padding: 25px 0; text-align: center; background-color: #f3f3f3;">
        <img src="<?php echo $url_img; ?>" onerror="<?php echo $error_url; ?>">
</div>
<div style="text-align: center; margin-top: 45px; margin-bottom: 45px;">
	<div style="display: inline-block; width: 570px;">
		<h1 style="font-family:Avenir,Helvetica,sans-serif;box-sizing:border-box;color:#2f3133;font-size:19px;font-weight:bold;margin-top:0;text-align:left">
			Hola, {{ $data['paciente']->nombres }}
		</h1>
		<p style="font-family:Avenir,Helvetica,sans-serif;box-sizing:border-box;color:#74787e;font-size:16px;line-height:1.5em;margin-top:0;text-align:left">
			{{ $data['cliente']->nombre }} te ha enviado tu presupuesto odontológico.
		</p>
		<p style="font-family:Avenir,Helvetica,sans-serif;box-sizing:border-box;color:#74787e;font-size:16px;line-height:1.5em;margin-top:0;text-align:left" >Para verlo hacer click en el boton.</p>
		<p style="text-align:center"><a href="{{$data['url']}}" style="font-family:Avenir,Helvetica,sans-serif;box-sizing:border-box;border-radius:0px;color:#fff;display:inline-block;text-decoration:none;background-color:#305f94;border-top:10px solid #305f94;border-right:18px solid #305f94;border-bottom:10px solid #305f94;border-left:18px solid #305f94" target="_blank">Ver Presupuesto</a></p>
	</div>
</div>
	
<div style="text-align: center; background-color: #f3f3f3; color: #aeaeae;">
        <div style="font-family:Avenir,Helvetica,sans-serif;padding:30px;color:#aeaeae;font-size:12px">
            © 2018 Odontoplus - Todos los derechos reservados
		</div>
</div>