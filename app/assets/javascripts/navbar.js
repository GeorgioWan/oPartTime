function resetName() {
  if (Cookies.get('name') != null) {
    var time = new Date();
    time.setTime( time.getTime() + ( 60 * 1000 ));
    Cookies.set('name', Cookies.get('name'), { expires: time });
  }
  setInterval('resetName()', 50 * 1000);
}

$(document).ready(function() {
  resetName();
});