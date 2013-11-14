require 'spec_helper'

feature 'UsersEventsSpecHelper' do
scenario "Dog can go see the event page from the doghouse" do
   go_to_doghouse_with_event
    expect(page).to_not have_content("You have no upcoming events!")
end

  scenario "Dog can go to the event page from the doghouse" do
    go_to_doghouse_with_event
    click_link "#{Event.last.title}"
    expect(page).to have_content("Title: #{Event.last.title}")
  end
  scenario "Event page will display event information"
  scenario "Dog can add friends from the event page"
  scenario "Dog can edit the Event"
end
