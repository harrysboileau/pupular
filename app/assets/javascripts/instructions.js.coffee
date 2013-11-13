removeFromScreen = (button) ->
  instruction = button.parentElement.parentElement
  instruction.remove()

$ ->
  $('.proceed_search_and_add').on "click", (event) ->
    event.preventDefault()
    removeFromScreen(this)

  $('.proceed_create_event').on "click", (event) ->
    event.preventDefault()
    removeFromScreen(this)
