# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready( ->
  $('.dish-list li i').click(() ->
    alert($(this).attr('action'))
    $.post($(this).attr('action')+".js", null, (data)->
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
