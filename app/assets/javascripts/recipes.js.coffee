# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $('#recipes-search').on 'keyup', ->
    $.ajax
      url: "/recipes/filter",
      delay: 500,
      data: {
        term: $(this).val(),
        user_id: $('#user-id').val()
      },
      success: (data, status, xhr) ->
        $('#recipes-partial').html(data)

