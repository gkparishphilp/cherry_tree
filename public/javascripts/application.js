// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/////////////////  Fancy-Pants for nested forms  ///////////////////
/////// This part can't be done unobtrusively since we need to pass in the assoc name
function add_fields( link, association, content ) {
  var new_id = new Date().getTime();
  var regexp = new RegExp( "new_" + association, "g" )
  $( link ).after( content.replace( regexp, new_id ) );
}

var full_path = 'http://thecherrytree.com/';

function remove_fields( link ) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}



$(document).ready(function(){
	$('#award_message').animate({
			left: "0%"
		}, 3500, 'swing', function(){
			$(this).delay(5000);
			$(this).animate({
				left: "-100%"
			}, 3500, function(){
				$(this).toggle();
			}
		);
		}
	);

	// THIS IS FOR THE PLANE SLIDING ACRESS THE SCREEN
	// Feedback message (need a different selector than #award_message)
	// $('#feedback_message').animate({
	// 		left: "0%"
	// 	}, 3500, 'swing', function(){
	// 		$(this).delay(5000);
	// 		$(this).animate({
	// 			left: "-100%"
	// 		}, 3500, function(){
	// 			$(this).toggle();
	// 		}
	// 	);
	// 	}
	// );

	// $('#feedback_message').click( function(){
	// 	$(this).animate({
	// 			left: "-100%"
	// 		}, 3500, function(){
	// 			$(this).toggle();
	// 		}
	// 	);
	// });

	// console.log($('#wrapper').height($(window).height()));


	
	
	$('#flash').click(function () {
		$(this).fadeOut(2000);
	});
	
	
	$('.archived_note').hover( function(){
		if( $(this).css('height') == '65px' ){
			$(this).animate({ height : 250, backgroundColor : '#fff' } );
			$(this).children('.archived_note_actions').show();
		}
		else{
			$(this).animate({ height: 65, backgroundColor : '#ffd' } );
			$(this).children('.archived_note_actions').hide();
		}
	});

	
	//$('.note').click( function(){
	//	$(this).hide( 2000 );
	//});
	
	$('.open_comment_form').click( function(){
		$('#comment_form_activity_' + $(this).attr('id') ).toggle( 300 );
	});
	
	
	$('.req_conf_assignment').click( function(){
		$('#loading_div').show();
		if( $(this).attr('checked') == true  ){
			var url = '/require_confirmation/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		}
		else{
			var url = '/remove_confirmation/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		}
		$.get( url );
		location.reload(true);
	});
	
	
	
	$('.requested_objective').click( function(){
		$('#loading_div').show();
		if( $(this).attr('checked') == true  ){
			var url = '/requested/objective/' + $(this).attr('objective') + '/for/' + $(this).attr('child');
		}
		else{
			var url = '/unrequested/objective/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		}
		$.get( url );
		location.reload(true);
	});
	
	$('.show_requested_goals').click( function() {
		$('#requested_goals').toggle('slow');
	});
	
	
	$('.assign_objective').live( 'click', function(){
		var url = '/activate/objective/' + $(this).attr('objective') + '/for/' + $(this).attr('child');
		$(this).closest(".objective").fadeOut( 'slow' ).remove();
		$.get( url );
	});
	
	
	$('.unassign_objective').live( 'click', function(){
		var url = '/deactivate/objective/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		$(this).closest(".objective_assignment").fadeOut( 'slow' ).remove();
		$.get( url );
	});

	$('.assign_lesson').live( 'click', function(){
		var url = '/activate/lesson/' + $(this).attr('lesson') + '/for/' + $(this).attr('child');
		$(this).closest(".lesson").fadeOut( 'slow' ).remove();
		$.get( url );
	});
	
	
	$('.unassign_lesson').live( 'click', function(){
		var url = '/update/lesson/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child') + "?status=inactive";
		$(this).closest(".lesson_assignment").fadeOut( 'slow' ).remove();
		$.get( url );
	});
	
	
	
	$('.assign_award').live( 'click', function(){
		var url = '/activate/award/' + $(this).attr('award') + '/for/' + $(this).attr('child');
		$(this).closest(".award").fadeOut( 'slow' ).remove();
		$.get( url );
	});
	
	
	$('.unassign_award').live( 'click', function(){
		var url = '/deactivate/award/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		$(this).closest(".award_assignment").fadeOut( 'slow' ).remove();
		$.get( url );
	});
	
	
	$('.objective_points').blur( function(){
		var url = '/update/objective/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		url += "?point_value=" + $(this).attr('value');
		$.get( url );
	});
	
	$('.objective_desc').blur( function(){
		var url = '/update/objective/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		url += "?description=" + $(this).attr('value');
		$.get( url );
	});
	
	
	$('.award_cost').blur( function(){

		var url = '/update/award/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		url += "?point_cost=" + $(this).attr('value');
		$.get( url );
	});
	
	$('.award_desc').blur( function(){
		var url = '/update/award/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		url += "?description=" + $(this).attr('value');
		$.get( url );
	});
	
	
	$('.open_new_award_form').click( function(){
		$('#new_award_assignment').show(300);
	});
	
	$('.close_new_award_form').click( function(){
		$('#new_award_assignment').hide(300);
	});
	
	
	$('.open_new_objective_form').click( function(){
		$('#new_objective_assignment').show(300);
	});
	
	$('.close_new_objective_form').click( function(){
		$('#new_objective_assignment').hide(300);
	});
		
	$('.award_modal').dialog({ 
		autoOpen: true, 
		modal: true, 
		width: 500, 
		dialogClass: 'award_message',
		open: function() {
			setTimeout(function(){
			    $('.award_modal').dialog('close');
			}, 3500);
		}});



	$('.modal').dialog({autoOpen: false, modal: true, width: 500});
	$('.open_modal').click( function(){
		$( "#new_" + $(this).attr('id') ).dialog('open');
		return false;
	});	
	
	// Changed class name here so we can use univeral "button" class for everything else.
	$('.jbutton').button();
	
	$('.datepicker').datepicker({
		dateFormat: 'mm/dd/yy'
	});
	
	$('.tabs').tabs();
	
	$('.birthday_field').datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'mm/dd/yy',
			defaultDate: '-10y'
		});
		
				
	/////////// Let's try some fancy judo for Child Reg  ////////////////
	$('#child_gender_male').click(function () {
		$('.gender').html( "His" );
	});
	$('#child_gender_female').click(function () {
		$('.gender').html( "Her" );
	});
	$('#child_display_name').keyup(function () {
		$('.name_owner').html( this.value + "'s" );
		$('.name').html( this.value );
	});
	
	
	$('#child_name').blur(function () {
		var url = '/check_name/' + this.value;
		$.get( url );
		//$('#name_availability').html( this.value );
		//$('#name_availability').css( 'color', '#090' );
	});
	
	
	
	///////////// Objective Form /////////////////////////////
	$('#objective_req_checkin').click( function() {
		$('#confirmation_fields').toggle();
	});
	
	$('#objective_objective_type').mouseup( function() {
		if( $(this).attr('value') == 'recurring' ){
			$('#recurring_fields').show( 'slow' );
			$('#one_time_fields').hide( 'slow' );
		}
		else{
			$('#recurring_fields').hide( 'slow' );
			$('#one_time_fields').show( 'slow' );
		}
	});
	
	// Used to save accordians state.
    var current = window.location.hash.replace("#", "");
	$(".child_profile #accordion").accordion({ autoHeight: false, active: parseInt(current), easing: 'swing' });
	var btn_submit = $('.save_form').attr("href");
	$(".child_profile #accordion h3").click(function(event){
		var index = $(".child_profile #accordion h3").index(this);
		$('.save_form').attr("href",btn_submit+"#"+index);
	});

	// http://stackoverflow.com/a/5398348/361689
	$('#slideshow').cycle({
       fx: 'fade',
       speed: 1000,
       timeout: 8000,
       pause: 1,
       cleartype: true,
       cleartypeNoBg: true,
       pager: '#slideshow-nav',
       pagerAnchorBuilder: function(idx, slide) {
           return '#slideshow-nav li:eq(' + (idx) + ')';
       },
       updateActivePagerLink: function(pager, currSlideIndex) {
   		    $(pager).find('li a').removeClass('active') 
   		        .filter('li a:eq('+currSlideIndex+')').addClass('active'); 
       }
   });
		// $.fn.cycle.updateActivePagerLink = function(pager, currSlideIndex) {
		// 		console.log(pager);
		//     $(pager).find('li').removeClass('activeLI') 
		//         .filter('li:eq('+currSlideIndex+')').addClass('activeLI'); 
		// }; 

   $('#slideshow-nav li').click(function() { 
       $('#slideshow').cycle('pause'); 
   });


	
});