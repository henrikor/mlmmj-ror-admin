$ ->
  $("#members").accordion()
  $("#members li").draggable()
#    if $('#unsub').val().match(ui.draggable.text())
#      $( ".selector" ).draggable( "option", "cancel", ".title" )

#   appendTo: "body")
#   helper: "clone"

  $("#cart ol").droppable(
    activeClass: "ui-state-default"
#    hoverClass: "ui-state-highlight"
    hoverClass: "ui-state-hover"
    accept: ":not(.ui-sortable-helper)"
    drop: (event, ui) ->
      if $('#unsub').val().match(ui.draggable.text())
      else
        $(this).find(".placeholder").remove()
        $("<li></li>").text(ui.draggable.text()).appendTo this
        $('#unsub').append(ui.draggable.text())
        return
  ).sortable
    items: "li:not(.placeholder)"
    sort: ->
      
      # gets added unintentionally by droppable interacting with sortable
      # using connectWithSortable fixes this, but doesn't allow you to customize active/hoverClass options
      $(this).removeClass "ui-state-default"
      return

  return

$(document).ready ->
  $(".listform form").submit ->
    currentId = $(this).attr('id')
    nr = currentId.replace("form","")
    # alert("#list"+nr)
    $("#list"+nr).addClass("submitted")
    # $(this).parents(".listform").addClass("submitted")
    return

# $(document).ready ->
#   $("#new_change").on("ajax:success", (e, data, status, xhr) ->
#     $("#new_change").append xhr.responseText
#   ).on "ajax:error", (e, xhr, status, error) ->
#     $("#new_change").append "<p>ERROR</p>"
