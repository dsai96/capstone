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

function buildSections ( data, omit_id ) {
	var sections = JSON.parse(data.responseText)

	var shown_sections = []
	var parsed_sections = {}

	var days_to_date = {
		'U': 14,
		'M': 15,
		'T': 16,
		'W': 17,
		'R': 18,
		'F': 19,
		'S': 20,
	}

	var colors = ['#CD5C5C', '#6e7bb2', '#6fa397']
	for (var i=0; i<sections.length; i++) {

		var id = sections[i][0]['id']
		var start_time = sections[i][0]['start_time'].split("T")[1].split(":")
		var end_time = sections[i][0]['end_time'].split("T")[1].split(":")
		var color = sections[i][2]; 

		var days = sections[i][0]['days'].trim().split("")

		for (var d=0; d<days.length; d++) {
			var day = days_to_date[days[d]]

			var event = {
    			content: sections[i][1].code,
	        	color: color,
    			startDate: new Date(2018, 0, day, parseInt(start_time[0]), parseInt(start_time[1])),
    			endDate: new Date(2018, 0, day, parseInt(end_time[0]), parseInt(end_time[1])),
    			course: sections[i][1]
    		}

			if (sections[i][1].id != omit_id && sections[i][0]['name'].includes('Lec')) {
    			shown_sections.push(event)
    		}

    		if (parsed_sections[id] == null) {
    			parsed_sections[id] = [event]
    		} else {
    			parsed_sections[id].push(event) 
    		}
		}
	}

	var options = $('input[name="section"]')
	for (var i=0; i<options.length; i++) {
		if (options[i].checked) {
			var id = options[i].id
			var these_sections = parsed_sections[id]
			for (var s=0; s<these_sections.length; s++) {
				if (these_sections[s]['course'].id != omit_id) {
					shown_sections.push(these_sections[s])
				}
			}
		}
	}

	return shown_sections

}

function renderSections ( sections ) {
	$('#calendar_view').empty();

	YUI().use(
	  'aui-scheduler',
	  function(Y) {
	    var events = sections;
	    // [
	    //   {
	    //     content: '15-112',
	    //     color: '#8aa382',
	    //     meeting: true,
	    //     endDate: new Date(2018, 0, 15, 14),
	    //     startDate: new Date(2018, 0, 15, 13)
	    //   }
	    // ];

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

$( document ).ready(function() {



	if ($('#schedule_plan').is(':visible')) {

		$.ajax ({
			url: 'student_sections.json',
		    complete: function (data) {

				var shown_sections = buildSections(data)	
				renderSections(shown_sections)	    	
		    }
		})
		
		// var days = document.getElementsByClassName('scheduler-view-day-header-day-number');
		// console.log(days.length)
		// for (var i=0; i < 7; i++) {
		// 	console.log(days)
		// 	days[i].html("<a href='#'><span>Monday</span></a>")
		// }
	}

	$('.ui.accordion')
	  $('.ui.accordion').accordion();
	;

	$( ".ui.checkbox" ).checkbox();
    
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

	$('.delete_added_course').bind( 'click', function( e ) {
		var id = e.currentTarget.id
		$.ajax ({
			url: 'student_sections.json',
		    complete: function (data) {
				var shown_sections = buildSections(data, id)	
				renderSections(shown_sections)	    	
		    }
		})
	});

	$('input[name=section]').change( function() { 
		if ($('#schedule_plan').is(':visible')) {
			$.ajax ({
				url: 'student_sections.json',
			    complete: function (data) {
					var shown_sections = buildSections(data)	
					renderSections(shown_sections)	    	
			    }
			})
		}
	});


	$('#requirements').bind("DOMSubtreeModified", function(){
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



