# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
newAlert = (type, message) ->
  $("#flash-message").append($("<div class='alert " + type + " fade in' data-alert='alert'><h5> " + message + " </h5></div>"));
  $(".alert").fadeIn(2000).delay(2000).fadeOut(2000, () ->
    $(this).remove()
  )


$(document).ready( ->
  $(".restaurant").click((event)->
    $("#account_restaurant").val($(this).text().trim())
  )
  $('.bill').click(() ->
    $.post($(this).attr('href')+".js", null, (data)->
      ap = $('#bill_'+data.bill_id).parent()
      if ap.find('i')
        ap.find('i').remove()
      ap.prepend("<i class='icon-ok green'></i>")

      if $.find("#destroy_"+data.account_id)
        $("#destroy_"+data.account_id).remove()

      if data.result=='clear'
        $("#status_"+data.account_id).text("Cleared").addClass("text-success")
    , "json")
    return false
  )
)
