require 'spec_helper'

describe Dog do
  let(:dog) { Dog.create(FactoryGirl.attributes_for(:dog)) }
  let(:pal) { Dog.create(FactoryGirl.attributes_for(:dog)) }
  context "associations" do

    it "will have friendships" do
      expect(dog.friendships).to be_an(Array)
    end

    it "will have pals" do
      Friendship.create(dog_id: dog.id, friend_id: pal.id)
      expect(dog.pals).to include(pal)
    end

    it "will have pending friendships" do
      pending_friendship = PendingFriendship.create(dog_id: pal.id, pending_friend_id: dog.id )
      expect(pal.pending_friendships).to include(pending_friendship)
    end

    it "will have pending_pals" do
      PendingFriendship.create(dog_id: pal.id, pending_friend_id: dog.id )
      expect(pal.pending_pals).to include(dog)
    end

    it "will have a profile" do
    profile = FactoryGirl.create(:profile, dog_id: dog.id)
    expect(dog.profile).to eq(profile)
    end

    it "will have sent messages" do
      message = FactoryGirl.create(:message, sender_id: dog.id)
      expect(dog.sent_messages).to include(Message.find(message.id))
    end

   it "will have many inbox messages" do
      message = FactoryGirl.create(:message, sender_id: pal.id)
      FactoryGirl.create(:inbox_message, dog_id: dog.id, message_id: message.id )
      expect(dog.inbox_messages).to include(InboxMessage.find_by_message_id(message.id))
    end

    it "will have received messages" do
      message = FactoryGirl.create(:message, sender_id: pal.id)
      FactoryGirl.create(:inbox_message, dog_id: dog.id, message_id: message.id )
      expect(dog.received_messages).to include(Message.find(message.id))
    end

    it "will have created many events" do
      event = FactoryGirl.create(:event, creator_id: dog.id )
      expect(dog.events).to include(Event.find(event.id))
    end

    it "will have attended many events" do
      event = FactoryGirl.create(:event, creator_id: pal.id )
      FactoryGirl.create(:event_attendance, event_id: event.id, dog_id: dog.id )
      expect(dog.attended_events).to include(Event.find(event.id))
    end
  end
end
