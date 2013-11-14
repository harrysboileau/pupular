require 'spec_helper'
require 'pry'

feature 'Message' do

  scenario "Page will display 'You don't have any messages' if there are none" do
    go_to_messages
    expect(page).to have_content("You don't have any messages")
  end

  scenario "Page will display sent messages if send message button is clicked", js: true do
    message = sent_message
    page.find("a#btm_br_msg").click
    page.find("a#show_sent_messages").click
    expect(page).to have_content(message.subject)
  end

  scenario "Dog can delete a message" do
    message = received_message
    page.find("a#btm_br_msg").click
    expect{click_link "Delete"}.to change(Message, :count).by(-1)
    expect(page).to_not have_content(message.subject)
  end

  scenario "Dog can reply to a message", js: true do
    message = received_message
    page.find("a#btm_br_msg").click
    click_link "Reply"
    expect(page.find('input#message_subject').value).to have_content("re: #{message.subject}")
  end

  scenario "Dog can send reply to message", js: true do
    message = received_message
    page.find("a#btm_br_msg").click
    click_link "Reply"
    click_button "throw a bone"
    expect(page).to have_content(message.subject)
  end

  scenario "Page will hide recieved messages if send message button is clicked, and it will display received messages when inbox is clicked", js: true do
   message = received_message
   page.find("a#btm_br_msg").click
   page.find("a#show_sent_messages").click
   expect(page).to_not have_content(message.subject)
   page.find("a#show_inbox").click
   expect(page).to have_content(message.subject)
 end

 scenario "Dog can link to to a new message" do
  go_to_new_message
  expect(page).to have_content("Write a message:")
end

scenario "Dog can send a message", js: true do
  go_to_messages
  Dog.find_by_name("tester").pals << create(:dog, name: "reciever")
  click_link "write a message"
  fill_in_message(attributes_for(:message), ["reciever"])
  click_button "throw a bone"
  expect(page).to have_content("reciever")
end

end
