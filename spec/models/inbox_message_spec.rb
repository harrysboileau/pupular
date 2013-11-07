require 'spec_helper'

describe InboxMessage do
  let(:dog) { FactoryGirl.create(:dog) }
  let(:message) { FactoryGirl.create(:message) }

  context 'associations' do
    it "will have received messages" do
      inbox = InboxMessage.create(dog_id: dog.id, message_id: message.id )
      expect(inbox.received_message).to eq(Message.find(message))
    end

    it "will have recipients" do
      inbox = InboxMessage.create(dog_id: dog.id, message_id: message.id )
      expect(inbox.recipient).to eq(dog)
    end
  end
end
