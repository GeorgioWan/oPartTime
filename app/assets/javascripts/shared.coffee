$ ->
  $(".dropdown-toggle").click (e) ->
    $(".dropdown-menu").slideToggle("fast")

$ ->
  if $('#back-to-top').length
    scrollTrigger = 100

    backToTop = ->
      scrollTop = $(window).scrollTop()
      if scrollTop > scrollTrigger
        $('#back-to-top').addClass 'show'
      else
        $('#back-to-top').removeClass 'show'
      return

    backToTop()
    $(window).on 'scroll', ->
      backToTop()
      return
    $('#back-to-top').on 'click', (e) ->
      e.preventDefault()
      $('html,body').animate { scrollTop: 0 }, 700
      return