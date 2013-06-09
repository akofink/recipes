$(document).on 'turbo:ready', ->
  $('.instant-tooltip').tooltip(
    animation: true
    trigger: 'focus'
    placement: 'right'
    html: true
  )
