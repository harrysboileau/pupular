editEventField = (location, name, value) ->
    location.replaceWith(editEventTextField(name, value))

editEventBox = (location, name, value) ->
    location.replaceWith(editEventTextBox(name, value))

editEventTime = (location, name, value) ->
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
    "<form>#{renderEventTextField(name, value)}<input type='submit' value='update'></form>"

renderEventTextField = (name, value) ->
    "<input id='#{name}' type='text' name='#{name}' value='#{value}'>"

editEventTextBox = (name, value) ->
    "<form>#{renderEventTextBox(name,value)}<input type='submit' value='update'></form>"

renderEventTextBox = (name, value) ->
    "<textarea id='#{name}' row='10' cols='30' name='#{name}'>#{value}</textarea>"

editEventDropdownBox = (name, values, original_value) ->
    "<form>#{renderEventDropdownBox(name, values, original_value)}<input type='submit' value='update'></form>"

renderEventDropdownBox = (name, values, original_value) ->
    options = renderSelections(values)
    "<select id='#{name}' name='#{name}'><option value='#{original_value}'>#{original_value}</option>#{options}</select>"

renderSelections = (array) ->
    string = ""
    string + "<option value='#{value}'>#{value}</option>" for value in array

editEventTimeDisplay = (name, value) ->
    "<form>#{renderEventTimeDisplay(name, value)}<input type='submit' value='update'></form>"

renderEventTimeDisplay = (name, value) ->
    time = convertEventDatetime(value)
    "<input  id='#{name}'  type='datetime-local' name='#{name}' value='#{time}'>"

newEventTrait = (value) ->
    "<div class='field'><div class='value'>#{value.value}</div></div>"

addEventForm = (dog_id, event_id) ->
    $('.event_details').wrap("<form id=mass_event></form>")
    $('.event_details').append("<input type='submit' value='update'>")
    $('#event_title .field .value').replaceWith(renderEventTextField("title", $('#event_title .field .value').text()))
    $('#event_type .field .value').replaceWith(renderEventDropdownBox("type", ["Walk", "Hangout"], $('#event_type .field .value').text()))
    $('#event_place .field .value').replaceWith(renderEventTextField("place", $('#event_place .field .value').text()))
    $('#event_description .field .value').replaceWith(renderEventTextBox("description", $('#event_description .field .value').text()))
    $('#event_start_time .field .value').replaceWith(renderEventTimeDisplay("start_time", $('#event_start_time .field .value').text()))
    $('#event_end_time .field .value').replaceWith(renderEventTimeDisplay("end_time", $('#event_end_time .field .value').text()))

listenForEventMassSubmit = (dog_id, event_id) ->
    $('#mass_event').on "submit", (event) ->
        event.preventDefault()
        data = {}
        data["value"] = getEventData()
        console.log(data["value"])
        submitMassProfileData(data, dog_id, event_id)

getEventData = ->
    eventData =
        title: $('input#title').val()
        type: $('select#type').val()
        location: $('input#place').val()
        description: $('textarea#description').val()
        start_time: $('input#start_time').val()
        end_time: $('input#end_time').val()

submitMassProfileData = (data, dog_id, event_id) ->
    $.ajax
        url: "/dogs/#{dog_id}/events/#{event_id}"
        data: data
        type: 'PUT'
        dataType: "json"
        success: (response) ->
            renderMassEventUpdate(response)

renderMassEventUpdate = (response) ->
    $('input#title').replaceWith(newMassEventTrait("title", response))
    $('select#type').replaceWith(newMassEventTrait("type", response))
    $('input#place').replaceWith(newMassEventTrait("location", response))
    $('textarea#description').replaceWith(newMassEventTrait("description", response))
    $('input#start_time').replaceWith(newMassEventTrait("start_time", response))
    $('input#end_time').replaceWith(newMassEventTrait("end_time", response))

newMassEventTrait = (key, value) ->
    "<div class='field'><div class='key'>#{value[key]}</div></div>"

$ ->
    $('input.edit_all_events').on "click", (event) ->
        event.preventDefault();
        dog_id = this.id
        event_id = this.name
        $(this).toggle();
        addEventForm()
        listenForEventMassSubmit(dog_id, event_id)

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
