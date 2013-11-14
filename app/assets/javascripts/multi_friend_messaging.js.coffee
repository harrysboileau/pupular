exports = this
exports.tally = 0

addFriendTo = (array) ->
  name = getRecipientName()
  array.push(name)

getRecipientName = ->
  return $('input#message_friends_search_input').val()

clearRecipientField = ->
  $('input#message_friends_search_input').val("")
recipientsList = []

postAllMessages = ->
  message_details = getMessageDetails()
  count = recipientsList.length
  sendMessageTo(dog, count, message_details ) for dog in recipientsList


sendMessageTo = (name, count, message_details) ->
  getIdOf({ "data" : name }, count, message_details)

getIdOf = (dog, count, message_details) ->
    $.ajax
        url: "/get_id"
        data: dog
        type: 'GET'
        dataType: "json"
        success: (response) ->
            sendMessage(response, count, message_details)

sendMessage = (recipient, count, message_details) ->
    $.ajax
      url: "/dogs/#{recipient["dog_id"]}/messages"
      data: message_details
      type: 'POST'
      dataType: "json"
      success: (response) ->
    exports.tally++
    if exports.tally == count
      window.location = "/dogs/#{recipient["current_dog_id"]}/messages"

getMessageDetails = ->
  messageDetails =
    subject: $('input#message_subject').val()
    content: $('textarea#message_content').val()
    type: "Personal"

$ ->
  $('#multi_friend_message_add').on "click", (event) ->
    event.preventDefault()
    addFriendTo(recipientsList)
    value = $('input#message_friends_search_input').val()
    clearRecipientField()
    $('#friends_to_message').append(value + '<br>')

  $('#message_submit').on "click", (event) ->
    event.preventDefault()
    postAllMessages()
