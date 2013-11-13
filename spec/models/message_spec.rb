require 'spec_helper'

describe Message do
  context 'associations' do
    it { should belong_to(:sender) }
    it { should have_many(:inbox_messages) }
    it { should have_many(:recipients) }
  end
  context 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:sender_id) }
    it { should validate_presence_of(:type) }
    it { should ensure_inclusion_of(:type).in_array(["Automated", "Personal"]) }

    it "will belong to the Personal class if passed the type 'Personal'" do
      dog = create(:dog)
      message = Message.create(attributes_for(:message, type: "Personal"))
      message.sender = dog
      message.save
      expect(Message.find(message.id)).to be_a(Personal)
    end

    it "will belong to the Automated class if passed the type 'Automated'" do
      dog = create(:dog)
      message = Message.create(attributes_for(:message, type: "Automated"))
      message.sender = dog
      message.save
      expect(Message.find(message.id)).to be_a(Automated)
    end

  end
end
