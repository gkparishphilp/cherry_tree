// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

/////////////////  Fancy-Pants for nested forms  ///////////////////
/////// This part can't be done unobtrusively since we need to pass in the assoc name
function add_fields( link, association, content ) {
  var new_id = new Date().getTime();
  var regexp = new RegExp( "new_" + association, "g" )
  $( link ).after( content.replace( regexp, new_id ) );
}

function remove_fields( link ) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}



$(document).ready(function(){
	
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
	
	$('.assign_award').click( function(){
		$('#loading_div').show();
		if( $(this).attr('checked') == true  ){
			$('#award_cost_' + $(this).attr('award') ).show( 300 );
			var url = '/activate/award/' + $(this).attr('award') + '/for/' + $(this).attr('child');
		}
		// todo -- look for award_assignment; create if none exists; set status according to checked state
		else{
			$('#award_cost_' + $(this).attr('award') ).hide( 300 );
			var url = '/deactivate/award/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		}
		$.get( url );
		location.reload(true);
	});
	
	$('.award_cost').blur( function(){

		var url = '/update/award/assignment/' + $(this).attr('assignment') + '/for/' + $(this).attr('child');
		url += "?point_cost=" + $(this).attr('value');
		$.get( url );

	});
	
	
	$('.open_new_award_form').click( function(){
		$('#new_award_assignment').show(300);
	});
	
	$('.close_new_award_form').click( function(){
		$('#new_award_assignment').hide(300);
	});
	
	
	$('.modal').dialog({ autoOpen: false, modal: true, width: 500 });
	
	$('.open_modal').click( function(){
		$( "#new_" + $(this).attr('id') ).dialog('open');
		return false;
	});	
	
	// Changed class name here so we can use univeral "button" class for everything else.
	$('.jbutton').button();
	
	$('.datepicker').datepicker({
		dateFormat: 'yy-mm-dd'
	});
	
	$('.tabs').tabs();
	
	$('.birthday_field').datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd',
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
	
});