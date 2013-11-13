require 'spec_helper'

feature 'Message' do

  scenario "Page will display 'You don't have any messages' if there are none" do
    go_to_messages
    expect(page).to have_content("You don't have any messages")
  end

  scenario "Page will display messages that Dog has received", js: true do
    message = received_message
    page.find("a#btm_br_msg").click
    expect(page).to have_content(message.subject)
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
    expect{click_link "Delete Message"}.to change(Message, :count).by(-1)
    expect(page).to_not have_content(message.subject)
  end

  scenario "Dog can reply to a message", js: true do
    message = received_message
    page.find("a#btm_br_msg").click
    click_link "Reply to Message"
    expect(page.find('input#message_subject').value).to have_content("re: #{message.subject}")
  end

  scenario "Dog can send reply to message", js: true do
    message = received_message
    page.find("a#btm_br_msg").click
    click_link "Reply to Message"
    page.find('.call_to_action').click
    expect(Dog.find_by_name("tester").sent_messages).to include(Message.where(subject: "re: #{message.subject}"))
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

scenario "Dog can send a message" do
  go_to_new_message
  message = fill_in_message(attributes_for(:message))
  page.find('.call_to_action').click
  page.find("a#show_sent_messages").click
  expect(page).to have_content(message.subject)
end

end
