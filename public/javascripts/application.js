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
	var ding = new Audio("/audio/ding.wav");
	var pop = new Audio("/audio/pop1.wav");
	var pop2 = new Audio("/audio/pop2.wav");
	var pop3 = new Audio("/audio/pop3.wav");
	var birds = new Audio("/audio/birds.mp3");
	

var audio = new Audio();

if( audio.canPlayType ){
	if( audio.canPlayType('audio/mpeg') != "" ){
		audio.src = '/audio/cherrytree.mp3'
	}
	else{
		audio.src = '/audio/cherrytree.ogg'
	}
}
else{
	$('#audio_control').hide();
}

audio.addEventListener('ended', function() {
	this.load();
    this.play();
}, false);


$(document).ready(function(){
	
	$(audio).bind('play',function() {
		$("#audio_control").html('Pause');   
		}).bind('pause', function() {
			$("#audio_control").html('Play');    
	});
	
	$('#audio_control').click( function(){
		if ( audio.paused || audio.ended ) { audio.play(); } 
  		else { audio.pause(); }     
	});
	
	$('.ding').mouseover( function() {
		pop3.load();
		pop3.play();
	});
	
	$('.ding').click(function() {
		pop2.load();
		pop2.play();
	});
	
	$('.pop').mouseenter( function() {
		pop2.load();
		pop2.play();
	});
	
	$('.pop').click(function() {
		pop3.load();
		pop3.play();
	});

	$('#flash').click(function () {
		$(this).fadeOut(2000);
	});
	
	
	
	$('#big_tree').mouseover( function(){
		$(this).animate({
			left:'+=166'
		});
		$(this).css( 'z-index', 10 );
		birds.load();
		birds.play();
	});
	
	$('#big_tree').mouseout( function(){
		$(this).animate({
			left:'-=166'
		});
		$(this).css( 'z-index', 3 );
		birds.pause();
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
	$('#tabs').tabs({
					cookie: {
						// store cookie for a day, without, it would be a session cookie
						expires: 1
					}
				});
				
	/////////// Let's try some fancy judo for Child Reg  ////////////////
	$('#child_gender_male').click(function () {
		$('.gender').html( "His" );
	});
	$('#child_gender_female').click(function () {
		$('.gender').html( "Her" );
	});
	$('#child_name').keyup(function () {
		$('.name').html( this.value + "'s" );
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