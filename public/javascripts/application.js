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
	
	$('.button').button();
	$('.datepicker').datepicker();
	$('.birthday_field').datepicker({
			changeMonth: true,
			changeYear: true,
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
	
	
});