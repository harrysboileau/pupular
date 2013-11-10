editProfileField = (location, name, value) ->
    location.replaceWith(editProfileTextField(name, value))

massEditProfileField = (location, name, value) ->
    location.replaceWith(renderProfileTextField(name, value))

editProfileFile = (location, name, value) ->
  location.replaceWith(editProfileFileField(name))

massEditProfileFile = (location, name, value) ->
  location.replaceWith(renderProfileFileField(name))

editProfileSelect = (location, name, value) ->
    selections = pickSelections(name)
    location.replaceWith(editProfileDropdownBox(name, selections, value))

massEditProfileSelect = (location, name, value) ->
    selections = pickSelections(name)
    location.replaceWith(renderProfileDropdownBox(name, selections, value))

pickSelections = (name) ->
      return ["Toy", "Small", "Medium", "Large", "Extra-large"] if name == "size"
      return ["Male", "Female"] if name == "gender"
      return [true, false] if name == "spayed"

listenForProfileSubmit = (location, key, profile_id, button) ->
    $("#{location} form").on 'submit', (event) ->
        event.preventDefault()
        $(button).toggle()
        submitProfile(key, this.firstChild.value, profile_id, this)

listenForMassSubmit = (profile_id) ->
    $("form#mass_profile").on 'submit', (event) ->
        event.preventDefault()
        data = {}
        data["value"] = getData()
        submitMassProfileData(data, profile_id)

submitMassProfileData = (data, id) ->
    $.ajax
        url: "/profiles/#{id}"
        data: data
        type: 'PUT'
        dataType: "json"
        success: (response) ->
          console.log(response)


getData = ->
    profileData =
        image: $('input#image').val()
        breed: $('input#breed').val()
        location: $('input#location').val()
        age: $('input#age').val()
        size: $('select#size').val()
        gender: $('select#gender').val()
        spayed: $('select#gender').val()


submitProfile = (key, value, profile_id, location) ->
    data = {}
    pass_value = {}
    data[key] = value
    pass_value["value"] = data
    updateProfileAttribute(pass_value, profile_id, location)

updateProfileAttribute = (value, profile_id, location) ->
    $.ajax
        url: "/profiles/#{profile_id}"
        data: value
        type: 'PUT'
        dataType: "json"
        success: (response) ->
          updateProfilePage(response, location)

updateProfilePage = (response, location) ->
    $(location).replaceWith(newProfileTrait(response))

editProfileTextField = (name, value) ->
    "<form>#{renderProfileTextField(name, value)}<input type='submit' value='update'></form>"

renderProfileTextField = (name, value) ->
    "<input type='text' id='#{name}' name='#{name}' value='#{value}'>"

editProfileFileField  = (name) ->
    "<form>#{renderProfileFileField(name)}<input type='submit' value='update'></form>"

renderProfileFileField = (name) ->
    "<input type='file' id='#{name}' name='#{name}'>"

editProfileDropdownBox = (name, values, current_value) ->
    "<form>#{renderProfileDropdownBox(name, values, current_value)}<input type='submit' value='update'></form>"

renderSelections = (array, first_value) ->
    "<option value='#{value}'>#{value}</option>" for value in array

renderProfileDropdownBox = (name, values, current_value) ->
    options = renderSelections(values)
    "<select id='#{name}' name='#{name}'><option value='#{current_value}'>#{current_value}</option>#{options}</select>"


newProfileTrait = (value) ->
    "<span id='value'>#{value.value}</div>"

editifyAllProfileFields = ->
    massEditProfileFile($('#profile_image #value'), "image", $('#profile_image_url #value').text())
    massEditProfileField($('#profile_breed #value'), "breed", $('#profile_breed #value').text())
    massEditProfileField($('#profile_location #value'), "location", $('#profile_location #value').text())
    massEditProfileField($('#profile_age #value'), "age", $('#profile_age #value').text())
    massEditProfileSelect($('#profile_size #value'), "size", $('#profile_size #value').text())
    massEditProfileSelect($('#profile_gender #value'), "gender", $('#profile_gender #value').text())
    massEditProfileSelect($('#profile_spayed #value'), "spayed", $('#profile_spayed #value').text())

addProfileForm = ->
    wrapProfileInForm()
    editifyAllProfileFields()

wrapProfileInForm = ->
    $('.users_profile').wrap("<form id=mass_profile></form>")
    $('.users_profile').append("<input type='submit' value='update'>")

$ ->
    $('input.edit_all_profile').on "click", (event) ->
      event.preventDefault();
      profile_id = this.id
      $(this).toggle();
      addProfileForm()
      listenForMassSubmit(profile_id)

    $('input.image').on "click", (event) ->
        event.preventDefault()
        button = this
        profile_id = this.id
        attribute = this.className
        $(this).toggle()
        editProfileFile($('#profile_image #value'), "#{attribute}", $('#profile_image_url #value').text())
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
        editProfileSelect($('#profile_size #value'), "#{attribute}", $('#profile_size #value').text())
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

