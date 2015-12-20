jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
        $('.pagination').html("<i class=\"fa fa-2x fa-spinner fa-pulse\"></i>")
        $('#loading').css("display", "block")
        # 利用 ajax 送出請求，載入並執行 js
        $.getScript(url)
      else if $(window).scrollTop() < $(document).height() - $(window).height() - 350
        $('#loading').css("display", "none")
        
    $(window).scroll()