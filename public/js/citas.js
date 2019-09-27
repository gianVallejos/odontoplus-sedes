$(document).ready(function() {
    // page is now ready, initialize the calendar
    var day_list = 'month';
    var sm_max_size = 768;
    var first_view = 0;
    var events = {
      url: global_url + '/v1/citas/get-all-events/null/null',
      error: function() { alert('Ha ocurrido un error al intentar cargar las citas.'); },

      // color: '#0aab8a',
      // textColor: '#f3f3f3'
    };
    //$('#spinner').hide();
    //console.log('!: Closed');
    function viewModeCallendar(){            
      if( first_view == 0 ){
        if ($(window).width() <= sm_max_size ) {
          day_list = 'listDay';
        } else {
          day_list = 'month';
        }        
        $('#calendar').fullCalendar('changeView', day_list);
        first_view = 1;
      }
    }

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
      eventRender: function(event, element){        
        viewModeCallendar();
      },
      loading: function (isLoading, view) {
        if( isLoading ){
          $('#spinner').show();
        }else{
          $('#spinner').hide();
        }
      },
      handleWindowResize: true,
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
                alert('Ha ocurrido un error. Consultar con soporte de Odontoplus')
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
      activate : function ( event , ui ) { $ ( '#calendar' ). fullCalendar ( 'render' ); },
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
        },
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
        if( event.idDoctor == 1 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#37be70', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#37be70'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 2 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#ff829d', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#ff829d'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 3 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#fffd4b', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#fffd4b'})
            element.find('.fc-time').css('color', '#707070')
            element.find('.fc-title').css('color', '#707070')
        }else if( event.idDoctor == 4 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#fb8e36', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#fb8e36'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 5 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#0e5ba3', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#0e5ba3'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 6 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#31adfc', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#31adfc'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else if( event.idDoctor == 7 ){
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#844bff', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#844bff'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }else{
            element.css({'border': 'none', 'background': 'transparent'})
            element.find('.fc-content').css({'background-color': '#0aab8a', 'color': '#c8c8c8', 'padding-left': '5px'})
            element.find('.fc-event-dot').css({'background-color': '#0aab8a'})
            element.find('.fc-time').css('color', '#f3f3f3')
            element.find('.fc-title').css('color', '#f3f3f3')
        }                
//       $('#spinner').hide();
//        console.log('!: Closed');
      }
    })
});
