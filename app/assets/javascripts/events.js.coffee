# itd be great if you could namespace all of these methods that currently pollute the global namespace...

editEventField = (location, name, value) ->
    location.replaceWith(editEventTextField(name, value))

editEventBox = (location, name, value) ->
    location.replaceWith(editEventTextBox(name, value))

editEventTime = (location, name, value) ->
    location.replaceWith(editEventStartTimeDisplay(name, time))

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
    "<textarea id='#{name}' row='30' cols='50' name='#{name}'>#{value}</textarea>"

editEventDropdownBox = (name, values, original_value) ->
    "<form>#{renderEventDropdownBox(name, values, original_value)}<input type='submit' value='update'></form>"

renderEventDropdownBox = (name, values, original_value) ->
    options = renderSelections(values)
    "<select id='#{name}' name='#{name}'><option value='#{original_value}'>#{original_value}</option>#{options}</select>"

renderSelections = (array) ->
    string = ""
    string + "<option value='#{value}'>#{value}</option>" for value in array

editEventStartTimeDisplay = (name, value) ->
    "<form>#{renderEventStartTimeDisplay(name, value)}<input type='submit' value='update'></form>"

renderEventStartTimeDisplay = (name, value) ->
    time = value
    "<select id='event_start_time_5i' name='event[start_time(5i)]'>#{renderSelections}</select>"

newEventTrait = (value) ->
    "<div class='field'><div class='value'>#{value.value}</div></div>"

addEventForm = (dog_id, event_id) ->
    $('.event_details').wrap("<form id='mass_event'></form>")
    $('.event_details').append("<input id='mass_event_button' type='submit' value='update'>")
    $('#event_title .value').replaceWith(renderEventTextField("title", $('#event_title .value').text()))
    $('#event_type .value').replaceWith(renderEventDropdownBox("type", ["Walk", "Hangout"], $('#event_type .value').text()))
    $('#event_place .value').replaceWith(renderEventTextField("place", $('#event_place .value').text()))
    $('#event_description .value').replaceWith(renderEventTextBox("description", $('#event_description .value').text()))
    $('#event_date .value').replaceWith(renderEventTextField("date", $("#event_date .value").text()))
    $('input#date').datepicker();
    $('#event_start_time .value').replaceWith(renderEventDropdownBox("time", ["05:00", "05:30", "06:00", "06:30", "07:00", "07:30", "08:00", "08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00", "17:30", "18:00", "18:30", "19:00", "19:30", "20:00", "20:30", "21:00", "21:30", "22:00", "22:30", "23:00", "23:30"], $('#event_start_time .value').text()))

listenForEventMassSubmit = (dog_id, event_id, button) ->
    $('#mass_event').on "submit", (event) ->
        event.preventDefault()
        data = {}
        data["value"] = getEventData()
        submitMassProfileData(data, dog_id, event_id)
        $('.event_details').unwrap()
        $('#mass_event_button').remove()
        $(button).toggle()

getEventData = ->
    eventData =
        title: $('input#title').val()
        type: $('select#type').val()
        location: $('input#place').val()
        description: $('textarea#description').val()
        date: $('input#date').val()
        start_time: $('select#time').val()

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
    $('input#date').replaceWith(newMassEventTrait("date", response))
    $('select#time').replaceWith(newMassEventTrait("start_time", response))

newMassEventTrait = (key, value) ->
    "<div class='field'><div class='key'>#{value[key]}</div></div>"

$ ->
    $('input.edit_all_events').on "click", (event) ->
        event.preventDefault();
        dog_id = this.id
        event_id = this.name
        $(this).toggle();
        addEventForm()
        listenForEventMassSubmit(dog_id, event_id, this)

    $('input.title').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventField($('#event_title .value'), 'title', $('#event_title .value').text())
        listenForEventSubmit('#event_title', 'title', dog_id, event_id, button)

    $('input.type').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventSelect($('#event_type .value'), 'type')
        listenForEventSubmit('#event_type', 'type', dog_id, event_id, button)

    $('input.location').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventField($('#event_place .value'), 'location', $('#event_place .value').text())
        listenForEventSubmit('#event_place', 'location', dog_id, event_id, button)

    $('input.description').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventBox($('#event_description .value'), 'description', $('#event_description .value').text())
        listenForEventSubmit('#event_description', 'description', dog_id, event_id, button)

    $('input.start_time').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventTime($('#event_start_time .value'), 'start_time', $('#event_start_time .value').text())
        listenForEventSubmit('#event_start_time', 'start_time', dog_id, event_id, button)

    $('input.end_time').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editEventTime($('#event_end_time .value'), 'end_time', $('#event_end_time .value').text())
        listenForEventSubmit('#event_end_time', 'end_time', dog_id, event_id, button)
