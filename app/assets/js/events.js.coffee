editField = (location, name, value) ->
    location.replaceWith(editTextField(name, value))

editBox = (location, name, value) ->
    location.replaceWith(editTextBox(name, value))

editTime = (location, name, value) ->
    time = convertDatetime(value)
    location.replaceWith(editTimeDisplay(name, time))

convertDatetime = (value) ->
    "#{value[0..9]}T#{value[11..18]}"

editSelect = (location, name, value) ->
    location.replaceWith(editDropdownBox(name, value))


listenForSubmit = (location, key, dog_id, event_id, button) ->
    $("#{location} form").on 'submit', (event) ->
        event.preventDefault()
        $(button).toggle()
        submit(key, this.firstChild.value, dog_id, event_id, this)

submit = (key, value, dog_id, event_id, location) ->
    data = {}
    stuff = {}
    data[key] = value
    stuff["value"] = data
    updateAttribute(stuff, dog_id, event_id, location)

updateAttribute = (value, dog_id, event_id, location) ->
    $.ajax
        url: "/dogs/#{dog_id}/events/#{event_id}"
        data: value
        type: 'PUT'
        dataType: "json"
        success: (response) ->
            renderUpdate(response, location)

renderUpdate = (response, location) ->
        $(location).replaceWith(newTrait(response))

editTextField = (name, value) ->
    "<form><input type='text' name='#{name}' value='#{value}'><input type='submit' value='update'></form>"

editTextBox = (name, value) ->
    "<form><textarea row='10' cols='30' name='#{name}'>#{value}</textarea><input type='submit' value='update'></form>"

editDropdownBox = (name) ->
    "<form><select name='#{name}'><option value='Walk'>Walk</option><option value='Hangout'>Hangout</option></select><input type='submit' value='update'></form>"

editTimeDisplay = (name, value) ->
    "<form><input id='date_time' type='datetime-local' name='#{name}' value='#{value}'><input type='submit' value='update'></form>"

newTrait = (value) ->
    "<div class='field'><div class='value'>#{value.value}</div></div>"

$ ->
    $('input.title').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editField($('#event_title .field .value'), 'title', $('#event_title .field .value').text())
        listenForSubmit('#event_title', 'title', dog_id, event_id, button)

    $('input.type').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editSelect($('#event_type .field .value'), 'type')
        listenForSubmit('#event_type', 'type', dog_id, event_id, button)

    $('input.location').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editField($('#event_place .field .value'), 'location', $('#event_place .field .value').text())
        listenForSubmit('#event_place', 'location', dog_id, event_id, button)

    $('input.description').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editBox($('#event_description .field .value'), 'description', $('#event_description .field .value').text())
        listenForSubmit('#event_description', 'description', dog_id, event_id, button)

    $('input.start_time').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editTime($('#event_start_time .field .value'), 'start_time', $('#event_start_time .field .value').text())
        listenForSubmit('#event_start_time', 'start_time', dog_id, event_id, button)

    $('input.end_time').on "click", (event) ->
        event.preventDefault()
        button = this
        dog_id = this.id
        event_id = this.name
        $(this).toggle()
        editTime($('#event_end_time .field .value'), 'end_time', $('#event_end_time .field .value').text())
        listenForSubmit('#event_end_time', 'end_time', dog_id, event_id, button)
