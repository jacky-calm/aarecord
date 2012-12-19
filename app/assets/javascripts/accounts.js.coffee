# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#

$(document).ready( ->
  $(".restaurant").click((event)->
    $("#account_restaurant").val($(this).text().trim())
  )
  $('.bill').click(() ->
    $.post($(this).attr('href')+".js", null, (data)->
      #noty({text: "Mark as paid successfully!", layout: "top"}) if (data.result == "success")
      alert("Post")
      $("#flash-message").val("Mark as paid successfully!").removeClass("hidden").alert()  if (data.result == "success")
    , "json")
    return false
  )
)
