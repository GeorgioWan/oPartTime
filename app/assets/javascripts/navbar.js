function updateNameExpires() {
  if (Cookies.get('name') != null) {
    var time = new Date();
    time.setTime( time.getTime() + ( 60 * 1000 ));
    Cookies.set('name', Cookies.get('name'), { expires: time });
  }
}

$(document).ready(function() {
  setInterval('updateNameExpires()', 50 * 1000);
});