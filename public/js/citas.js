$(document).ready(function() {
    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
      eventSources: [
        {
          url: global_url + '/v1/citas/get-all-events',
          color: '#0aab8a',
          textColor: '#f3f3f3'
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
      eventClick: function(calEvent, jsEvent, view) {
        console.log(calEvent)

        $(this).css('border-color', '#305f94');

      },
      dayClick: function(date, jsEvent, view) {
        $('#calendar').fullCalendar('changeView', 'listDay')
        $('#calendar').fullCalendar('gotoDate', date)
      },
      header: {
        left: 'prev,next month, today',
        center: 'title',
        right: 'listMonth,listWeek,listDay crearCitaBtn'
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
