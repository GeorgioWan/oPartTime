$(document).ready(function(){

  $('path').click(function(){
    window.location.href = $(this).data('city');
  });
  
});