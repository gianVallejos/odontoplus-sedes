$(document).ready(function() {
    // page is now ready, initialize the calendar
    var events = {
      url: global_url + '/v1/citas/get-all-events',
      error: function() { alert('...'); },
      color: '#0aab8a',
      textColor: '#f3f3f3'
    };

    $("select[name='id_doctor']").change(function(){
      if ($(this).val() == 'all') {
        events.url = global_url + '/v1/citas/get-all-events'
      }
      else {
        events.url = global_url + '/v1/citas/get-all-events/' + $(this).val();
      }
      $('#calendar').fullCalendar('removeEventSources');
      $('#calendar').fullCalendar('addEventSource', events);
      $('#calendar').fullCalendar('refetchEvents');
    });

    $('#calendar').fullCalendar({
      eventSources: [ events ],
      monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
      monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
      dayNames: ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'],
      dayNamesShort: ['Dom','Lun','Mar','Mié','Jue','Vie','Sáb'],
      editable: true,
      eventDrop: function(event, delta, revertFunc) {
        var date = new Date(event.start)
        var fecha = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate()
        // if (confirm("Are you sure about this change?")) {
          $.ajax({
            type: "GET",
            url: global_url + '/v1/citas/update-fecha-cita/' + fecha + '/' + event.idEvent,
            success: function(data){
              if( data.success == 'updated' ){
                console.log('Cita movida correctamente')
              }else{
                alert('Ha ocurrido un errro. Consultar con soporte de Odontoplus')
              }
            },
            error: function(error){
              alert(JSON.stringify(error))
            }
          })
        // }else{
        //   revertFunc()
        // }
      },
      eventClick: function(calEvent, jsEvent, view) {
        $(this).css('border-color', '#305f94');
        window.location.href = global_url + '/citas/' + calEvent.idEvent
      },
      dayClick: function(date, jsEvent, view) {
        $('#calendar').fullCalendar('changeView', 'listDay')
        $('#calendar').fullCalendar('gotoDate', date)
      },
      header: {
        left: 'prev,next month, today',
        center: 'title',
        right: 'listDay,listWeek,listMonth crearCitaBtn'
      },
      customButtons: {
        crearCitaBtn: {
          text: 'Nueva Cita',
          click: function() {
            window.location.href = global_url + '/citas/create'
          }
        }
      },
      buttonText: {
        today: 'Hoy',
        month: 'Calendario',
        listMonth: 'Mes',
        listWeek: 'Semana',
        listDay: 'Día'

      },
      allDayText: 'Todo el día'
    })
});
