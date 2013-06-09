$(document).on 'turbo:ready', ->
  $('tr.table-link').on 'click', ->
    location.href = $(this).find('a').attr('href')
