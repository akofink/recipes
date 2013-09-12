# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  $(document).on 'click', '.comment a', (event) ->
    $(this).toggleClass 'to-edit'

  $(document).on 'click', '.comment .btn', (event) ->
    $(this).toggleClass 'to-show'

  $(document).on 'click', '#new_comment .btn', (event) ->
    $('#comments').append("<div class='comment'><div class='to-show'></div></div>")

  $(document).ajaxSuccess (event, xhr, options) ->
    $('.to-edit').parents('.comment').html(xhr.responseText)
    $('.to-show').parents('.comment').html(xhr.responseText)
    $('#new_comment').find('.field').children().val('')