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
  count = recipientsList.length
  sendMessageTo(dog,count) for dog in recipientsList


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
    data = getMessageDetails()
    $.ajax
      url: "/dogs/#{recipient["dog_id"]}/messages"
      data: data
      type: 'POST'
      dataType: "json"
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

  $('input#message_submit.call_to_action').on "click", (event) ->
    event.preventDefault()
    postAllMessages()
