editField = (location, name, value) ->
    location.replaceWith(editTextField(name, value))

editBox = (location, name, value) ->
    location.replaceWith(editTextBox(name, value))

editTime = (location, name, value) ->
    time = convertDatetime(value)
    location.replaceWith(editTimeDisplay(name, time))

editSelect = (location, name, value) ->
    location.replaceWith(editDropdownBox(name, value))
