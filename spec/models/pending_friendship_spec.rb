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

  context "methods" do
    describe "#approve!" do
      before(:each) do
        @dog = create(:dog)
        @pal = create(:dog)
        @pending_friendship = PendingFriendship.new
        @pending_friendship.dog_id = @dog.id
        @pending_friendship.pending_friend_id = @pal.id
        @pending_friendship.save!
        @pending_friendship.approve!
      end

      it "should create a friendship for the dog containing the friend_id" do
        friendship = Friendship.find_by_dog_id(@dog.id)
        expect(friendship).to be_a(Friendship)
        expect(friendship.friend_id).to eq(@pal.id)
      end

      it "should create a friendship for the pal containing the dog_id" do
        friendship = Friendship.find_by_dog_id(@pal.id)
        expect(friendship).to be_a(Friendship)
        expect(friendship.friend_id).to eq(@dog.id)
      end

      it "should destroy the pending_friendship" do
        expect(PendingFriendship.find_by_id(@pending_friendship.id)).to be_nil
      end
    end
  end
end
