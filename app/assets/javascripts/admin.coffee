changeAccepted = (acc, jobid, elem_acc)->
  $.ajax({
    method: "POST",
    url: "/admin/accepted",
    data: { accepted: acc, id: jobid },
    success:(data) ->
      elem_acc.text(acc)
      if acc == "pass" 
        elem_acc.addClass('accepted-status-'+'pass').removeClass('accepted-status-'+'failed') 
      else
        elem_acc.removeClass('accepted-status-'+'pass').addClass('accepted-status-'+'failed')
        
      return false
    error:(data) ->
      alertify.error("審核有誤，請回報，謝謝喲！")
      return false
  })
  
setNavbarAdminFixed = ->
  if (/ipad/i.test(navigator.userAgent.toLowerCase()))
    $("#oPartTime-navbar-admin").addClass("navbar-fixed-top")
  else if (/iphone|ipod|android|blackberry|mini|windows\sce|palm/i.test(navigator.userAgent.toLowerCase()))
      $("#oPartTime-navbar-admin").addClass("navbar-fixed-top")
  else
    $("#oPartTime-navbar-admin").removeClass("navbar-fixed-top")
  
$ ->
  setNavbarAdminFixed()
  
  $("td").on "click", ".accepted", ->
    elem_acc = $(this).parent().parent().children("#accepted-status-" + $(this).attr('jobid')).children('span')
    changeAccepted($(this).attr('id'), $(this).attr('jobid'), elem_acc)