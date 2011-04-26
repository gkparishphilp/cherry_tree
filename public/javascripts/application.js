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
	
	$('#style_target textarea').addClass( "font_" + $('.font_select option:first').html() );

	$('.font_select').change( function(){
		$(this).children('option:selected').each( function(){
			var existing_font_class = $('#style_target textarea').attr("class").match(/font_\w+/)
			$('#style_target textarea').removeClass( existing_font_class );
			$('#style_target textarea').addClass( "font_" + this.text );
		});
	});
	
	
	$('#style_target textarea').addClass( "bg_" + $('.bg_select option:first').html() );

	$('.bg_select').change( function(){
		$(this).children('option:selected').each( function(){
			var existing_bg_class = $('#style_target textarea').attr("class").match(/bg_\w+/);
			
			alert( "All classes: " + $('#style_target textarea').attr("class") + " Removing: '" + existing_bg_class +"'" );
			
			$('#style_target textarea').removeClass(existing_bg_class);
			$('#style_target textarea').addClass( "bg_" + this.text );
			
			alert( $('#style_target textarea').attr("class") );
		});
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
		
		
	$('#open_sticker_drawer').click( function(){
		$('#sticker_drawer').toggle('slow');
	});
	
	
	$('.resizable').resizable({
		minWidth: 16,
		maxWidth: 800,
		resize: function(){
			if( $(this).attr('id').replace( /_.*/, "" ) == 'heading' ){
				$(this).css('fontSize', $(this).height() );
			}
			else if( $(this).attr('id').replace( /_.*/, "" ) == 'picture'  ){
				$(this).children('img').attr('width', $(this).width());
			}
		},
		stop: function(event, ui){
			var id = $(this).attr('id').replace( /.*_/, "" );
			var type = $(this).attr('id').replace( /_.*/, "" );
			var width = $(this).width();
			var height = $(this).height();
			
			var the_url = "http://localhost:3000/update_page/" + type + "/" + id + "?width=" + width + "&height=" + height;

			$.get( the_url );
			
		}
	});
	
	
	
	$('.del_toggle').bind( "contextmenu", function(event) {
		event.preventDefault();
		$(this).siblings('.delete_sticker').toggle();
	});

		
	$('.draggable').draggable({
		containment: "parent",
		stack: ".draggable",
		stop: function(){
			var id = $(this).attr('id').replace( /sticking_/, "" );
			var top = $(this).position().top;
			var left = $(this).position().left
			
			var the_url = "http://localhost:3000/stickings/" + id + "/update_pos?top=" + top + "&left=" + left

			$.get( the_url );

			
		}
		
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