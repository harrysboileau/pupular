require 'spec_helper'

feature "Welcome Page" do
  scenario "it will have 'Sign In' and 'Sign Up' links " do
    visit root_path
    expect(page).to have_content("Sign Up")
    expect(page).to have_content("Sign In")
  end

  scenario "it will properly link to 'Sign Up'" do
    go_to_signup
    expect(page).to have_content("Sign Up!")
  end

  scenario "it will properly link to 'Sign In'" do
    go_to_login
    expect(page).to have_content("Welcome Back")
  end
end

feature "Sign Up" do
  let(:error_message) {"prohibited this dog from being saved"}
  scenario "New dog is created when valid data is passed" do
    expect{guest_sign_up(attributes_for(:dog))}.to change(Dog, :count).by(1)
  end

  scenario "Error is posted when no email is provided" do
    go_to_signup
    fill_out_human_info(attributes_for(:dog, email: ""))
    expect(page).to have_content(error_message)
  end

  scenario "Error is posted when no password is provided" do
    go_to_signup
    fill_out_human_info(attributes_for(:dog, password: ""))
    expect(page).to have_content(error_message)
  end

  scenario "Error is posted when no confirmation password is provided" do
    go_to_signup
    fill_out_human_info(attributes_for(:dog), "banana" )
    expect(page).to have_content(error_message)
  end

  scenario "Error is posted when invalid dog username" do
    guest_sign_up(attributes_for(:dog, username:""))
    expect(page).to have_content(error_message)
  end

  scenario "Error is posted when invalid dog name" do
    guest_sign_up(attributes_for(:dog, username:""))
    expect(page).to have_content(error_message)
  end
end

feature 'Dog Profile Creation' do
  scenario "User is directed to page to create dog's profile" do
    guest_sign_up(attributes_for(:dog))
    expect(page).to have_content("Make your profile")
  end

  scenario "User can skip creating dog's profile" do
    guest_sign_up(attributes_for(:dog))
    click_link "skip"
    expect(page).to have_content("Upcoming Events:")
  end

end

feature 'Sign In' do
  let(:error_message) {"prohibited this dog from being saved"}
  scenario "Dog is signed in with valid credentials using email" do
    dog = create(:dog)
    dog_login_email(dog)
    expect(page).to have_content("Upcoming Events:")
  end

  scenario "Dog is signed in with valid credentials using username" do
    dog = create(:dog)
    dog_login_username(dog)
    expect(page).to have_content("Upcoming Events:")
  end

  scenario "Dog is not signed in if pasword is not valid" do
    dog = create(:dog, password: "wrongpass")
    dog_login_username(dog)
    expect(page).to have_content(error_message)
  end

  scenario "Dog is not signed in if email or username are not valid" do
    dog = build(:dog)
    dog_login_username(dog)
    expect(page).to have_content(error_message)
    dog_login_email(dog)
    expect(page).to have_content(error_message)
  end
end
