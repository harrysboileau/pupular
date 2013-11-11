addFriendTo = (array) ->
  name = getRecipientName()
  array.push(name)

getRecipientName = ->
  return $('input#dog_id').val()

clearRecipientField = ->
  $('input#dog_id').val("")
recipientsList = []

postAllMessages = ->
  sendMessageTo(dog) for dog in recipientsList
  window.location = '/doghouse'


sendMessageTo = (name) ->
  getIdOf({ "data" : name })

getIdOf = (dog) ->
    $.ajax
        url: "/get_id"
        data: dog
        type: 'GET'
        dataType: "json"
        success: (response) ->
            sendMessage(response)

sendMessage = (recipient) ->
    data = getMessageDetails()
    console.log(data)
    $.ajax
      url: "/dogs/#{recipient["dog_id"]}/messages"
      data: data
      type: 'POST'
      dataType: "json"
      success: ->
        console.log("success")

getMessageDetails = ->
  messageDetails =
    subject: $('input#message_subject').val()
    content: $('textarea#message_content').val()
    type: "Personal"


$ ->
  $('#multi_friend_message_add').on "click", (event) ->
    event.preventDefault()
    addFriendTo(recipientsList)
    clearRecipientField()

  $('input#message_submit.call_to_action').on "click", (event) ->
    event.preventDefault()
    postAllMessages()
