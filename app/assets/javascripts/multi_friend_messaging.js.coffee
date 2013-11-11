addFriendTo = (array) ->
  name = getRecipientName()
  array.push(name)

getRecipientName = ->
  return $('input#dog_id').val()

clearRecipientField = ->
  $('input#dog_id').val("")
recipientsList = []

postAllMessages = ->
  count = recipientsList.length
  sendMessageTo(dog,count--) for dog in recipientsList

sendMessageTo = (name, count) ->
  getIdOf({ "data" : name }, count)

getIdOf = (dog, count) ->
    $.ajax
        url: "/get_id"
        data: dog
        type: 'GET'
        dataType: "json"
        success: (response) ->
            sendMessage(response, count)

sendMessage = (recipient, count) ->
    console.log(recipient)
    data = getMessageDetails()
    console.log(data)
    $.ajax
      url: "/dogs/#{recipient["dog_id"]}/messages"
      data: data
      type: 'POST'
      dataType: "json"
    if count == 1
      window.location.href = "/doghouse"

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
