$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
      events: [
          {
              title  : 'Event1',
              start  : '2018-12-01'
          },
          {
              title  : 'Event2',
              start  : '2018-12-05 15:00:00',
              end    : '2018-12-07 15:00:00'
          },
          {
              title  : 'Event3',
              start  : '2018-12-09 12:30:00',
              allDay : false // will make the time show
          }
      ],
      monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
      monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
      dayNames: ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'],
      dayNamesShort: ['Dom','Lun','Mar','Mié','Jue','Vie','Sáb'],
      editable: true,
      eventDrop: function(event, delta, revertFunc) {

        alert(event.title + " was dropped on " + event.start.format());

        if (!confirm("Are you sure about this change?")) {
          revertFunc();
        }

      },
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,listWeek,listMonth crearCitaBtn'
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
        listWeek: 'Semana',
        listMonth: 'Mes'
      },
      allDayText: 'Todo el día'
    })

});
