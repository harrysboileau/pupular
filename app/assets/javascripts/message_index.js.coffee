
$ ->
  $('#show_inbox').on "click", (event) ->  
    event.preventDefault()
    $('#dog_inbox').removeClass("not_active")
    $('#dogs_sent_messages').addClass("not_active")

  $('#show_sent_messages').on "click", (event) ->
    event.preventDefault()
    $('#dogs_sent_messages').removeClass("not_active")
    $('#dog_inbox').addClass("not_active")
