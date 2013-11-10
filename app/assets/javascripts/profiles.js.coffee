editProfileField = (location, name, value) ->
    location.replaceWith(editProfileTextField(name, value))

editProfileSelect = (location, name) ->
    console.log(name)
    value = pickSelections(name)
    console.log(value)
    location.replaceWith(editProfileDropdownBox(name, value))

pickSelections = (name) ->
      console.log(name)
      return ["Toy", "Small", "Medium", "Large", "Extra-large"] if name == "size"
      return ["Male", "Female"] if name == "gender"
      return ["Yes", "No"] if name == "spayed"

listenForProfileSubmit = (location, key, profile_id, button) ->
    $("#{location} form").on 'submit', (event) ->
        event.preventDefault()
        $(button).toggle()
        submitProfile(key, this.firstChild.value, profile_id, this)

submitProfile = (key, value, profile_id, location) ->
    data = {}
    pass_value = {}
    data[key] = value
    pass_value["value"] = data
    updateProfileAttribute(pass_value, profile_id, location)

updateProfileAttribute = (value, profile_id, location) ->
    console.log($(location))
    $.ajax
        url: "/profiles/#{profile_id}"
        data: value
        type: 'PUT'
        dataType: "json"
        success: (response) ->
          renderProfileUpdate(response, location)


renderProfileUpdate = (response, location) ->
    $(location).replaceWith(newProfileTrait(response))

editProfileTextField = (name, value) ->
    "<form><input type='text' name='#{name}' value='#{value}'><input type='submit' value='update'></form>"

editProfileDropdownBox = (name, values) ->
    options = renderSelections(values)
    "<form><select name='#{name}'>#{options}</select><input type='submit' value='update'></form>"

renderSelections = (array) ->
  option = ""
  option + "<option value='#{value}'>#{value}</option>" for value in array


newProfileTrait = (value) ->
    "<div id='value'>#{value.value}</div>"

$ ->
    $('input.photo').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileField($('#profile_image #value'), "#{attribute}", $('#profile_image_url #value').text())
        listenForProfileSubmit('#profile_image', attribute, profile_id, button)

    $('input.breed').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileField($('#profile_breed #value'), "#{attribute}", $('#profile_breed #value').text())
        listenForProfileSubmit('#profile_breed', attribute, profile_id, button)

    $('input.dogs_location').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = "location"
        $(this).toggle()
        editProfileField($('#profile_location #value'), "location", $('#profile_location #value').text())
        listenForProfileSubmit('#profile_location', attribute, profile_id, button)

    $('input.age').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileField($('#profile_age #value'), "#{attribute}", $('#profile_age #value').text())
        listenForProfileSubmit('#profile_age', attribute, profile_id, button)

    $('input.size').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileSelect($('#profile_size #value'), "#{attribute}")
        listenForProfileSubmit('#profile_size', attribute, profile_id, button)

    $('input.gender').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileSelect($('#profile_gender #value'), "#{attribute}", $('#profile_gender #value').text())
        listenForProfileSubmit('#profile_gender', attribute, profile_id, button)

    $('input.spayed').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileSelect($('#profile_spayed #value'), "#{attribute}", $('#profile_spayed #value').text())
        listenForProfileSubmit('#profile_spayed', attribute, profile_id, button)

