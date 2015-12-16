jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next a').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 150
        $('.pagination').html("<i class=\"fa fa-2x fa-spinner fa-pulse\"></i>")
        # 利用 ajax 送出請求，載入並執行 js
        $.getScript(url)
    $(window).scroll()