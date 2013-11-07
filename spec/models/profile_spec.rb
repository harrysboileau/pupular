require 'spec_helper'

describe Profile do
    let(:dog) { FactoryGirl.create(:dog) }
    let(:size) { ["toy", "small", "medium", "large", "extra-large"].sample }
  context "associations" do
    it "will belong to a dog" do
      profile = Profile.new( photo: "http://localhost:3000",
        breed: Faker::Lorem.word,
        location: Faker::Lorem.words,
        age: (1..10).to_a.sample,
        gender: ["male", "female"].sample,
        spayed: [true,false].sample )
      profile.size = size
      profile.save
      dog.profile = profile
      expect(profile.dog).to eq(dog)
    end
  end
end
