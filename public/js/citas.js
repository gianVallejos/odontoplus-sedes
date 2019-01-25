$(document).ready(function() {
    // page is now ready, initialize the calendar
    var events = {
      url: global_url + '/v1/citas/get-all-events/null/null',
      error: function() { alert('Ha ocurrido un error al intentar cargar las citas.'); },
      // color: '#0aab8a',
      // textColor: '#f3f3f3'
    };

    $("select[name='id_doctor']").change(function(){
      var doctorId = $(this).val() == 'all' ? null : $(this).val();
      var sedeId = $("select[name='id_sede']").val() == 'all' ? null : $("select[name='id_sede']").val();
      reloadCalendar(doctorId, sedeId)
    });

    $("select[name='id_sede']").change(function(){
      var sedeId = $(this).val() == 'all' ? null : $(this).val();
      var doctorId = $("select[name='id_doctor']").val() == 'all' ? null : $("select[name='id_doctor']").val();
      reloadCalendar(doctorId, sedeId)
    });

    function reloadCalendar(doctorId, sedeId) {
      events.url = global_url + '/v1/citas/get-all-events/'+ doctorId +'/' + sedeId
      console.log(events.url);
      $('#calendar').fullCalendar('removeEventSources');
      $('#calendar').fullCalendar('addEventSource', events);
      $('#calendar').fullCalendar('refetchEvents');
    }

    $('#calendar').fullCalendar({
      eventSources: [ events ],
      monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
      monthNamesShort: ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'],
      dayNames: ['Domingo','Lunes','Martes','Miércoles','Jueves','Viernes','Sábado'],
      dayNamesShort: ['Dom','Lun','Mar','Mié','Jue','Vie','Sáb'],
      // editable: true,
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
      locale: 'es',
      eventLimit: true,
      allDayText: 'Todo el día',
      eventAfterRender: function (event, element, view) {
        console.log(event.title)
        console.log(element.find('.fc-title'))
        if( event.idDoctor == 1 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#c55673', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#c55673'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 2 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#438a8e', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#438a8e'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 3 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#729453', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#729453'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 4 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#c88254', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#c88254'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 5 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#48639e', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#48639e'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 6 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#74b5ff', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#74b5ff'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 7 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#6b9430', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#6b9430'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else{
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#0aab8a', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#0aab8a'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }
      }
    })
});
