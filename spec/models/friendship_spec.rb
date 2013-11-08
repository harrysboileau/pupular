require 'spec_helper'

describe Friendship do
  context "association" do
    it { should belong_to(:dog) }
    it { should belong_to(:pal) }
  end

context "validations" do
    it { should validate_presence_of(:dog_id)}
    it { should validate_presence_of(:friend_id)}
    it { should validate_uniqueness_of(:dog_id).scoped_to(:friend_id) }
  end
end
