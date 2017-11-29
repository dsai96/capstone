// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require semantic-ui

function deactivateNavItems () {
	$( ".nav-item" ).each( function( i, item ) {
    	$(item).addClass("nav-inactive")
	});
} 

$( document ).ready(function() {

	if ($('#schedule_plan').is(':visible')) {

		$.ajax ({
			url: 'student_sections.json',
		    complete: function (data) {
		    	console.log(data.responseText)
		    	// get events
		    }
		})
	      

		YUI().use(
		  'aui-scheduler',
		  function(Y) {
		    var events = [
		      {
		        content: 'Partial Lunar Eclipse',
		        endDate: new Date(2013, 3, 25, 5),
		        startDate: new Date(2013, 3, 25, 1)
		      },
		      {
		        color: "#8d8",
		        content: 'Earth Day Lunch',
		        disabled: true,
		        endDate: new Date(2013, 3, 22, 13),
		        meeting: true,
		        reminder: true,
		        startDate: new Date(2013, 3, 22, 12)
		      }
		    ];

		    var agendaView = new Y.SchedulerAgendaView();
		    var dayView = new Y.SchedulerDayView();
		    var weekView = new Y.SchedulerWeekView({

		    });
		    var monthView = new Y.SchedulerMonthView();

		    var eventRecorder = new Y.SchedulerEventRecorder();

		    new Y.Scheduler(
		      {
		        activeView: weekView,
		        boundingBox: '#calendar_view',
		        date: new Date(2018, 0, 15),
		        eventRecorder: eventRecorder,
		        items: events,
		        render: true,
		        views: [weekView]
		      }
		    );
		  }
		);
	}

	$('.ui.accordion')
	  $('.ui.accordion').accordion();
	;
    
    $('.ui.dropdown').dropdown({
		onChange: function(values) {
		    $.ajax({
	            type: 'GET',
	            url: '/fetch_courses',      
	            data: {values},
	        });
		}
	});
	
	$('[id^="req-"]').progress();

	// initialize accordian dropdown every time a new set of courses 
	// are rendered for a filter
	$('#courses_list').bind("DOMSubtreeModified", function(){
		$('.ui.accordion').accordion();
	});

	$('#added_courses').bind("DOMSubtreeModified", function(){
		$('.ui.accordion').accordion();
	});


	if ($('#home').is(':visible')) {
    	deactivateNavItems();
    	$( "#nav-progress" ).removeClass("nav-inactive");
		$( "#nav-progress" ).addClass("nav-active");
    }

    else if ($('#requirements').is(':visible')) {
    	deactivateNavItems();
    	$( "#nav-requirements" ).removeClass("nav-inactive");
		$( "#nav-requirements" ).addClass("nav-active");
    }

    else if ($('#courses').is(':visible')) {
    	deactivateNavItems();
    	$( "#nav-all_courses" ).removeClass("nav-inactive");
		$( "#nav-all_courses" ).addClass("nav-active");
    }

    else if ($('#schedule_plan').is(':visible')) {
    	deactivateNavItems();
    	$( "#nav-schedule" ).removeClass("nav-inactive");
		$( "#nav-schedule" ).addClass("nav-active");
    }

});



