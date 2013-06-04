$(document).on 'ready page:load', ->

  $('.table-link').on 'click', ->
    location.href = $(this).find('a').attr('href')
