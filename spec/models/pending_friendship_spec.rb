require 'spec_helper'

describe PendingFriendship do
  context "associations" do
    it { should belong_to(:dog) }
    it { should belong_to(:pending_pal) }
  end

 context "validations" do
    it { should validate_presence_of(:dog_id) }
    it { should validate_presence_of(:pending_friend_id) }
    it { should validate_uniqueness_of(:pending_friend_id).scoped_to(:dog_id) }
  end
end
