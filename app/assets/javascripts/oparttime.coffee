# navbar change color when scroll down
navbarColor = ->
  scrollTrigger = 200
  scrollTop = $(window).scrollTop()
  if scrollTop > scrollTrigger
    $('#oPartTime-navbar-landing').addClass 'oPartTime-navbar-landing shadow-z-1'
  else
    $('#oPartTime-navbar-landing').removeClass 'oPartTime-navbar-landing shadow-z-1'
  return
  
# Typing slogan via TypedJQ-rails gem 
sloganShowUp = ->
  $("h2.oparttime-slogan-static").fadeIn "slow", ->
    $("h4.oparttime-slogan-static").fadeIn "slow", ->
      $(".btn-findjobs").fadeIn "slow", ->
        $(".oparttime-landing-img").addClass("in-view")
        sloganTypedAnimation()
        
sloganTypedAnimation = ->
  $("#oparttime-slogan-typed").typed
    strings: ["找頭路", "徵人才", "兼差", "加入！"]
    cursorChar: "｜"
    typeSpeed : 150
    backSpeed : 50
    startDelay: 500
    backDelay : 1000
    loop      : true

$ ->
  $.material.init()
  
  $('.body-landing').hide(0).delay(500).fadeIn 'fast', ->
    sloganShowUp()
    return
    

  $(window).on 'scroll', ->
    navbarColor()
    return
    
      
  
    