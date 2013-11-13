require 'spec_helper'

describe Profile do

  context "associations" do
      it { should belong_to(:dog)}
  end

  context "validations" do
    it { should ensure_inclusion_of(:gender).in_array(["", "Male","Female"]) }
    it { should ensure_inclusion_of(:size).in_array(["", "Toy", "Small", "Medium", "Large", "Extra-large"]) }
  end

  context "methods" do
    describe "#not_empty?" do
      it "should return true if any of the fields are filled in" do
        profile = Profile.create(age: 2)
        expect(profile.not_empty?).to be_true
        profile = Profile.create(gender: "Male")
        expect(profile.not_empty?).to be_true
      end

      it "should treutn false of none of the fields are filled in" do
        profile = Profile.create
        expect(profile.not_empty?).to_not be_true
      end
    end
  end
end
