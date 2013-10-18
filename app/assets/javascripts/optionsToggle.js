$(document).ready(function(){
  $('i.icon-down').on('click', function(){
    $('#page-options-toggle1').css({"display": "none"})
    $('#page-options-toggle2').css({"display": "block"})
  });
  $('i.icon-up').on('click', function(){
    $('#page-options-toggle1').css({"display": "block"})
    $('#page-options-toggle2').css({"display": "none"})
  });
});







