require 'spec_helper'

describe Friendship do
  let(:dog) { Dog.create(FactoryGirl.attributes_for(:dog)) }
  let(:pal) { Dog.create(FactoryGirl.attributes_for(:dog)) }
  it "will belong to a dog" do
    dog.pals << pal
    expect(Friendship.find_by_dog_id(dog.id)).to be_true
  end

  it "will belong to a pal" do
    dog.pals << pal
    expect(Friendship.find_by_friend_id(pal.id)).to be_true
  end
end
