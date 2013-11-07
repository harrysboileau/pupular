require 'spec_helper'

describe Message do
  let(:sender) { FactoryGirl.create(:dog) }
  let(:recipient) { FactoryGirl.create(:dog) }

  context 'associations' do
    before(:each) do
      @message = Message.new(FactoryGirl.attributes_for(:message))
      @message.sender_id = sender.id
      @message.save
      @inbox = FactoryGirl.create(:inbox_message, dog_id: recipient.id, message_id: @message.id )
    end

    it "will belong to a sender" do
      expect(@message.sender).to eq(sender)
    end

    it "will have many inbox messages" do
      expect(@message.inbox_messages).to include(@inbox)
    end

    it "will have many recipients" do
      expect(@message.recipients).to include(recipient)
    end

  end
end
