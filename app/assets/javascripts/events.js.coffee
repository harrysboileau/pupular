editEventField = (location, name, value) ->
    location.replaceWith(editEventTextField(name, value))

editEventBox = (location, name, value) ->
    location.replaceWith(editEventTextBox(name, value))

editEventTime = (location, name, value) ->
    time = convertEventDatetime(value)
    location.replaceWith(editEventTimeDisplay(name, time))

convertEventDatetime = (value) ->
    "#{value[0..9]}T#{value[11..18]}"

editEventSelect = (location, name, value) ->
    location.replaceWith(editEventDropdownBox(name, value))


listenForEventSubmit = (location, key, dog_id, event_id, button) ->
    $("#{location} form").on 'submit', (event) ->
        event.preventDefault()
        $(button).toggle()
        submitEvent(key, this.firstChild.value, dog_id, event_id, this)

submitEvent = (key, value, dog_id, event_id, location) ->
    data = {}
    stuff = {}
    data[key] = value
    stuff["value"] = data
    updateEventAttribute(stuff, dog_id, event_id, location)

updateEventAttribute = (value, dog_id, event_id, location) ->
    $.ajax
        url: "/dogs/#{dog_id}/events/#{event_id}"
        data: value
        type: 'PUT'
        dataType: "json"
        success: (response) ->
            renderEventUpdate(response, location)

renderEventUpdate = (response, location) ->
        $(location).replaceWith(newEventTrait(response))

editEventTextField = (name, value) ->
    "<form><input type='text' name='#{name}' value='#{value}'><input type='submit' value='update'></form>"

editEventTextBox = (name, value) ->
    "<form><textarea row='10' cols='30' name='#{name}'>#{value}</textarea><input type='submit' value='update'></form>"

editEventDropdownBox = (name) ->
    "<form><select name='#{name}'><option value='Walk'>Walk</option><option value='Hangout'>Hangout</option></select><input type='submit' value='update'></form>"

editEventTimeDisplay = (name, value) ->
    "<form><input id='date_time' type='datetime-local' name='#{name}' value='#{value}'><input type='submit' value='update'></form>"

newEventTrait = (value) ->
    "<div class='field'><div class='value'>#{value.value}</div></div>"

$ ->
    $('input.title').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventField($('#event_title .field .value'), 'title', $('#event_title .field .value').text())
        listenForEventSubmit('#event_title', 'title', dog_id, event_id, button)

    $('input.type').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventSelect($('#event_type .field .value'), 'type')
        listenForEventSubmit('#event_type', 'type', dog_id, event_id, button)

    $('input.location').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventField($('#event_place .field .value'), 'location', $('#event_place .field .value').text())
        listenForEventSubmit('#event_place', 'location', dog_id, event_id, button)

    $('input.description').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventBox($('#event_description .field .value'), 'description', $('#event_description .field .value').text())
        listenForEventSubmit('#event_description', 'description', dog_id, event_id, button)

    $('input.start_time').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventTime($('#event_start_time .field .value'), 'start_time', $('#event_start_time .field .value').text())
        listenForEventSubmit('#event_start_time', 'start_time', dog_id, event_id, button)

    $('input.end_time').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventTime($('#event_end_time .field .value'), 'end_time', $('#event_end_time .field .value').text())
        listenForEventSubmit('#event_end_time', 'end_time', dog_id, event_id, button)
