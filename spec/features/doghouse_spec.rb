require 'spec_helper'

feature 'Doghouse' do

  scenario "new dog will have instructions to find friends and create events" do
    sign_up
    expect(page).to have_content("To Search & Add Friends")
    expect(page).to have_content("To Create Walks & Hangouts")
  end

  scenario "user can navigate to the messages page from the bottom navbar" do
    sign_up
    page.find("a#btm_br_msg").click
    expect(page).to have_content("write a message")
  end

  scenario "user can navigate to their profile page from the bottom navbar" do
    sign_up
    page.find("a#btm_br_prf").click
    expect(page).to have_content("Breed")
  end

  scenario "user can navigate to the new event page from the bottom navbar" do
    sign_up
    page.find("a#btm_br_evt").click
    expect(page).to have_content("Create Event")
  end

  scenario "user can sign out bottom navbar" do
    sign_up
    expect(DogSession.find).to_not be_nil
    page.find("a#btm_br_lgt").click
    expect(DogSession.find).to be_nil
  end
  scenario "dog can click button to hide search instructions", js: true do
    sign_up
    page.find(".proceed_search_and_add").click
    expect(page).to_not have_content("To Search & Add Friends")
  end

  scenario "dog can click button to hide event instructions", js: true do
    sign_up
    page.find(".proceed_create_event").click
    expect(page).to_not have_content("To Create Walks & Hangouts")
  end

  scenario "dog can not see itself in the friend's list", js: true do
    open_search_bar
    fill_in "search_search_term", with: "tester"
    expect(page).to_not have_content("tester")
  end

  scenario "dog can see a friend from the search bar via name", js: true do
    pal = create(:dog)
    open_search_bar
    fill_in "search_search_term", with: pal.name[0]
    expect(page).to have_content(pal.name)
  end

scenario "dog can see a friend from the search bar via username", js: true do
    pal = create(:dog)
    open_search_bar
    fill_in "search_search_term", with: pal.username[0]
    expect(page).to have_content(pal.name)
  end

  scenario "dog can see a friend from the search bar via email", js: true do
    pal = create(:dog)
    open_search_bar
    fill_in "search_search_term", with: pal.email[0]
    expect(page).to have_content(pal.name)
  end

  scenario "dog can add a friend from the search bar", js: true do
    pal = create(:dog, name: "pal_tester")
    open_search_bar
    fill_in "search_search_term", with: pal.name
    page.find(".add_friend_button").click
    expect(pal.pending_pals).to have(1).outstanding_requests
  end
end
