// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
	
	$('#flash').click(function () {
		$(this).fadeOut(2000);
	});
	
	$('.button').button();
	$('.datepicker').datepicker();
	$('#tabs').tabs();
});