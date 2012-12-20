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
      newAlert('success', 'Mark as paid successfully!')
    , "json")
    return false
  )
)
