$(document).ready(function() {

    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
      events: [
          {
              title  : 'event1',
              start  : '2010-01-01'
          },
          {
              title  : 'event2',
              start  : '2010-01-05',
              end    : '2010-01-07'
          },
          {
              title  : 'event3',
              start  : '2010-01-09 12:30:00',
              allDay : false // will make the time show
          }
      ]
    })

});
