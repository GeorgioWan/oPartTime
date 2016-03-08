backToTop = ->
  scrollTrigger = 100
  scrollTop = $(window).scrollTop()
  if scrollTop > scrollTrigger
    $('#back-to-top').addClass 'show'
  else
    $('#back-to-top').removeClass 'show'
  return
      
$ ->
  # Tooltip binding
  $("body").tooltip({ selector: '[data-toggle="tooltip"]' })

  # Menu with slideToggle
  $(".dropdown-toggle").click (e) ->
    $(".dropdown-menu").slideToggle("fast")

  # Back to top
  if $('#back-to-top').length

    backToTop()
    
    $(window).on 'scroll', ->
      backToTop()
      return
    $('#back-to-top').on 'click', (e) ->
      e.preventDefault()
      $('html,body').animate { scrollTop: 0 }, 700
      return
      
  # Confirm with alertify
  $.rails.allowAction = (element) ->
    if undefined == element.attr('data-confirm')
      return true
    $.rails.showConfirmDialog element
    false
  
  $.rails.confirmed = (element) ->
    element.removeAttr 'data-confirm'
    element.trigger 'click.rails'
    return
  
  $.rails.showConfirmDialog = (element) ->
    msg = element.data('confirm')
    alertify.confirm msg, (e) ->
      if e
        $.rails.confirmed element
      return
    return