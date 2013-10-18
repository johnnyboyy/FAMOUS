$(document).ready(function(){
  // $('#togoogler').on('click', function(){
  //   if ($('#page-options-toggle1').hasClass('is-active')) {
  //     $('#page-options-toggle1').toggle()
  //     $('#page-options-toggle2').toggle()
  //   }

  //   else {
  //     $('#page-options-toggle1').toggle()
  //     $('#page-options-toggle2').toggle()
  //   }
  // });

  $('#page-options-toggle2').children().first().on('click', function(){
    $('#page-options-toggle1').toggle()
    $('#page-options-toggle2').toggle()
  });
  $('#page-options-toggle1').children().first().on('click', function(){
    $('#page-options-toggle1').toggle()
    $('#page-options-toggle2').toggle()
  });
});









