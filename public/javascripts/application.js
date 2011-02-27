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

// experiment with audio
	var pop = new Audio("/audio/pop.wav");
	var pop2 = new Audio("/audio/pop2.wav");
	var bird = new Audio("/audio/bird.wav");

$(document).ready(function(){
	// experimental soundeffects
	
	$('.pop').mouseenter( function() {
		pop.load();
		pop.play();
	});
	
	$('.pop').click(function() {
		pop2.load();
		pop2.play();
	});
	
	$('#flash').click(function () {
		$(this).fadeOut(2000);
	});
	
	/*
	$('#big_tree').click( function(){
		$(this).animate({
			left:'+=166'
		});
		$(this).css( 'z-index', 10 );
		bird.load();
		bird.play();
	});
	
	$('#big_tree').mouseout( function(){
		$(this).animate({
			left:'-=166'
		});
		$(this).css( 'z-index', 3 );
		bird.pause();
	});
	*/
	
	$('#note_font').change( function(){
		$('.note_content textarea').css('font-family', this.value );
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
	
	
	$('#modal_form').dialog({ autoOpen: false, modal: true, width: 500 });
	
	$('#open_modal').click( function(){
		$('#modal_form').dialog('open');
		return false;
	});
	
	
	
	$('.button').button();
	
	$('.datepicker').datepicker({
		dateFormat: 'yy-mm-dd'
	});
	$('.birthday_field').datepicker({
			changeMonth: true,
			changeYear: true,
			dateFormat: 'yy-mm-dd',
			defaultDate: '-10y'
		});
		
	
	$('.resize')	.resizable({
		aspectRatio: 1 / 1,
		maxWidth: 200,
		minWidth: 16,
		stop: function(event, ui){
			var id = $(this).attr('id').replace( /sticking_/, "" );
			var width = $(this).width()
			
			var the_url = "http://localhost:3000/stickings/" + id + "/stick?width=" + width
			$(this).children('img').attr('width', $(this).width());
			
			$.get( the_url );
			
		}
	});
		
	$('.sticking').draggable({
		containment: "parent",
		stack: ".sticking",
		stop: function(){
			var id = $(this).attr('id').replace( /sticking_/, "" );
			var top = $(this).position().top;
			var left = $(this).position().left
			
			var the_url = "http://localhost:3000/stickings/" + id + "/stick?top=" + top + "&left=" + left

			$.get( the_url );

			
		}
		
	});
		
	//$('#tabs').tabs({
	//				cookie: {
	//					// store cookie for a day, without, it would be a session cookie
	//					expires: 1
	//				}
	//			});
				
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