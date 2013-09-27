# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).ready(function(){
	$('.member_options').hide()
	$('.member_options_toggle').on('click', function{
		$('member_options').show()
	})
});
