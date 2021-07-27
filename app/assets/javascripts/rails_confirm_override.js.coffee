# Override the default confirm dialog by rails
$.rails.allowAction = (link) ->
  if link.data('confirm')
    $.rails.showConfirmationDialog(link)
    false
  else
    true

# User click confirm button
$.rails.confirmed = (link) ->
  link.data('confirm', null)
  link.trigger('click')

# Display the confirmation dialog
$.rails.showConfirmationDialog = (link) ->
  message = link.data('confirm')
  title = link.data('title') || 'Warning'
  sweetAlert
    title: title
    html: message
    type: 'warning'
    showCancelButton: true
    confirmButtonColor: '#DD6B55'
    confirmButtonText: 'Yes'
    closeOnConfirm: true
    animation: false
  , ->
      $.rails.confirmed(link)
