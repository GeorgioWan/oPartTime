showTabPane = ->
  active_city_id = $("ul.nav.nav-pills").children("li.active").children("a").attr("aria-controls")
  
  if active_city_id
    elem = $('.tab-content').children('.tab-pane#'+active_city_id)
    elem.addClass('active in')
  
$ ->
  showTabPane()