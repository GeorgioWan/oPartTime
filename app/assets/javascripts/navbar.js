function updateNameExpires() {
  if (Cookies.get('name') != null) {
    var time = new Date();
    time.setTime( time.getTime() + ( 60 * 1000 ));
    Cookies.set('name', Cookies.get('name'), { expires: time });
  }
}

function setNavbarFixed(){
  if (/ipad/i.test(navigator.userAgent.toLowerCase()))
    $("#oPartTime-navbar").addClass("navbar-fixed-top");
  else if (/iphone|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()))
      $("#oPartTime-navbar").addClass("navbar-fixed-top");
  else
    $("#oPartTime-navbar").removeClass("navbar-fixed-top");
}

$(document).ready(function() {
  setInterval('updateNameExpires()', 50 * 1000);
  
  setNavbarFixed();
});