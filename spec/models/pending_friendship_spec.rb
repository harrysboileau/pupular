require 'spec_helper'

describe PendingFriendship do
  let(:dog) { Dog.create(FactoryGirl.attributes_for(:dog)) }
  let(:pal) { Dog.create(FactoryGirl.attributes_for(:dog)) }

  it "will belong to a dog" do
    dog.pending_pals << pal
    expect(PendingFriendship.find_by_dog_id(dog.id)).to be_true
  end

  it "will belong to a pending_pal" do
    dog.pending_pals << pal
    expect(PendingFriendship.find_by_pending_friend_id(pal.id)).to be_true
  end
end
