$ ->
  $(".oPartTime-city").click ->
    cityId = $(this).data("cityid")
    districts = $.get( ("/taiwan_city/" + cityId), (data) ->
      i = 0
      items = []
      len = data.length
      while i < len
        option = data[i]
        items.push( "<li><a href='/" + cityId + "?district="+ option[1] + "'>" + option[0] + "</a></li>" )
        i++
     
      $( ".pContent" ).html($( "<ul/>", {
        "class": "nav nav-pills",
        html: items.join( "" )
      }))
    )
    
    $('.districtsContent').fadeIn('slow')