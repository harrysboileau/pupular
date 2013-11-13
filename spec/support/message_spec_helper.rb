module MessageSpecHelper
  def go_to_messages
    sign_up
    page.find("a#btm_br_msg").click
  end

  def received_message
    message = inbox_message
    sign_up
    deliver(message)
    message
  end

  def inbox_message
    create(:dog).sent_messages.create(attributes_for(:message, type: "Personal"))
  end

  def deliver(message, name="tester")
    Dog.find_by_name(name).received_messages << message
  end

  def sent_message
    pal = create(:dog)
    sign_up
    message = create_message
    deliver(message, pal.name)
    message
  end

  def go_to_new_message
    go_to_messages
    click_link "write a message"
  end

  def create_message
    Dog.find_by_name("tester").sent_messages.create(attributes_for(:message, type: "Personal"))
  end

  def fill_in_message(message, pals=[create(:dog)])
    fill_in "message_subject", with: message[:subject]
    pals.each do |pal|
      fill_in "message_friends_search_input", with: pal[:name]
      find("input#multi_friend_message_add").click
    end
    fill_in "message_content", with: message[:content]
    message
  end

end
