require 'spec_helper'

feature 'UserProfile' do
  scenario "Dog can fill out profile after signing up" do
    profile_sign_up
    fill_out_profile
    expect{click_button "Make Profile"}.to change(Profile, :count).by(1)
  end
  scenario "Dog can skip profile after signing up" do
    profile_sign_up
    click_link "skip"
    expect(page).to have_content("You have no upcoming events")
  end
  scenario "If dog has not filled out profile they will be prompted when they press the profile button" do
    profile_sign_up
    click_link "skip"
    page.find("#btm_br_prf").click
    expect(page).to have_content("skip")
  end
  scenario "Dog can see their own profile when they click the profile button" do
    profile_sign_up
    fill_out_profile
    click_button "Make Profile"
    page.find("#btm_br_prf").click
    expect(page).to have_content("tester")
  end
  scenario "Dog can edit their own profile", js: true do
    profile_sign_up
    fill_out_profile
    click_button "Make Profile"
    page.find("#btm_br_prf").click
    click_button "edit"
    fill_in "breed", with: "banana"
    click_button "update"
    expect(page).to have_content "banana"
  end
end
