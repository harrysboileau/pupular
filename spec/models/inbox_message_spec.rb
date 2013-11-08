require 'spec_helper'

describe InboxMessage do
  context 'associations' do
    it { should belong_to(:received_message) }
    it { should belong_to(:recipient) }
  end

  context "validations do" do
  it { should validate_presence_of(:dog_id) }
  it { should validate_presence_of(:message_id) }
  it { should validate_uniqueness_of(:message_id).scoped_to(:dog_id)}
  end
end
