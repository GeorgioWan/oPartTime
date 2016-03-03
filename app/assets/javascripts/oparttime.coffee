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
sloganTypedAnimation = ->
  $("#oparttime-slogan-typed").typed
    strings: ["哈囉！打工仔！^1500<br><br>
              oPartTime 讓你<strong>「免費查找、張貼」</strong>打工資訊喔！^1500<br><br>
              趕緊加入我們吧！"]
    cursorChar: "｜"
    startDelay: 1000
    callback: ->
      $("#oparttime-slogan").delay(3000).fadeOut "slow", ->
        $("h2.oparttime-slogan-static").fadeIn "slow", ->
          $("h4.oparttime-slogan-static").fadeIn "slow", ->
            $(".btn-findjobs").fadeIn "slow", ->
              $(".oparttime-scrolldown").addClass("in-view")

$ ->
  $.material.init()
  
  $('.body-landing').hide(0).delay(500).fadeIn 'fast', ->
    sloganTypedAnimation()
    return
    
  $('.oparttime-landing-pagedown').hide(0).delay(700).fadeIn('fast')

  $(window).on 'scroll', ->
    navbarColor()
    return
  
  $('.btn-scrolldown').on 'click', ->
    $('html,body').animate { scrollTop: $($(this).attr("href")).offset().top }, 1000
    
      
  
    