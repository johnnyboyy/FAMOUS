$(document).ready(function(){
  $('#page-options-toggle2').children().first().on('click', function(){
    $('#page-options-toggle1').toggle()
    $('#page-options-toggle2').toggle()
  });
  $('#page-options-toggle1').children().first().on('click', function(){
    $('#page-options-toggle1').toggle()
    $('#page-options-toggle2').toggle()

  });
});









