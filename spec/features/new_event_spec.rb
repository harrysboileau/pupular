require 'spec_helper'

feature "NewEvent" do
  scenario "New Message screen has an option for the type of walk" do
    go_to_new_event
    expect(page).to have_content("Are you making a:")
  end

  scenario "Event is type: Hangout when 'Hangout' is selected", js: true do
    go_to_new_event
    create_hangout_event
    expect(Event.last).to be_a(Hangout)
  end

  scenario "Event is type: Walk when 'Walk' is selected", js: true do
    go_to_new_event
    create_walk_event
    expect(Event.last).to be_a(Walk)
  end

  scenario "Error is rendered on screen when invalid data is provided" do
    go_to_new_event
    find('button.Walk').click
    submit
    expect(page).to have_content("prohibited this dog from being saved")
  end

  scenario "Dog is routed to add friends after event is created and can add them", js: true do
    go_to_new_event
    pal = add_pal
    create_walk_event
    expect(page).to have_content("Add Friends to Event")
    add_pal_to_event(pal)
    expect(Event.last.invited_pals).to include(pal)
  end

  scenario "Event is displayed on the doghouse after created" do
    go_to_new_event
    create_walk_event
    visit doghouse_path
    expect(page).to have_content(Event.last.title)
  end
end
