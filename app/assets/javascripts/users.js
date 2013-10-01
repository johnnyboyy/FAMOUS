$(document).ready(function(){
	$('.likes').one("click", function(){$(this).parent().parent().remove()});
});