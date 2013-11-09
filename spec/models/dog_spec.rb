require 'spec_helper'

describe Dog do
  let(:dog) { Dog.create(attributes_for(:dog)) }
  let(:pal) { Dog.create(attributes_for(:dog)) }
  context "associations" do
    it { should have_many(:friendships) }
    it { should have_many(:pals)}
    it { should have_many(:pending_friendships) }
    it { should have_many(:pending_pals) }
    it { should have_one(:profile)}
    it { should have_many(:sent_messages)}
    it { should have_many(:inbox_messages)}
    it { should have_many(:received_messages)}
    it { should have_many(:events)}
    it { should have_many(:attended_events)}
  end

  context "validations" do

    it "will be valid if email, password, name, and username are valid" do
      expect(Dog.create(attributes_for(:dog))).to be_valid
    end

    it { should validate_uniqueness_of(:email) }
    it { should_not allow_value("").for(:email) }

    it "will not be valid if email is not the propper format" do
      expect(Dog.create(attributes_for(:dog, email: "cat" )).errors.messages[:email].to_s).to match(/look like an email/)
    end

    it "will not be valid if username is blank" do
      expect(Dog.create(attributes_for(:dog, username: "" )).errors.messages[:username].to_s).to match(/is too short/)
    end

    it "will not be valid if username is too short" do
      expect(Dog.create(attributes_for(:dog, username: "ab" )).errors.messages[:username].to_s).to match(/is too short/)
    end

    it "will not be valid if user uses invalid characters" do
      expect(Dog.create(attributes_for(:dog, username: "~" )).errors.messages[:username].to_s).to match(/use only letters/)
    end

    it { should validate_uniqueness_of(:username) }

    it "will not be valid if password is blank" do
      expect(Dog.create(attributes_for(:dog, password: "" )).errors.messages[:password].to_s).to match(/too short/)
    end

    it "will not be valid if password is too short" do
      expect(Dog.create(attributes_for(:dog, password: "cat" )).errors.messages[:password].to_s).to match(/too short/)
    end
  end

  context "methods" do
    describe "#accept_pal" do
      before(:each) do
        @dog = dog
        @pal = pal
        @dog.pending_pals << @pal
        @dog.accept_pal(@pal.id)
      end

      it "will add pending_pal to pals" do
        dog = Dog.find(@dog.id)
        expect(dog.pals).to include(@pal)
      end

      it "will remove pending_pal from pending_pals" do
        dog = Dog.find(@dog.id)
        expect(dog.pending_pals).to_not include(@pal)
      end
    end
    describe "#deny_pal" do
      let(:dog) { Dog.create(attributes_for(:dog)) }
      let(:pal) { Dog.create(attributes_for(:dog)) }
      before(:each) do
        @dog = dog
        @pal = pal
        @dog.pending_pals << @pal
        @pending_friendship = @dog.pending_friendships.find_by_pending_friend_id(@pal.id)
        @dog.deny_pal(@pal.id)
      end

      it "will remove pending_pal from pending_pals" do
        dog = Dog.find(@dog.id)
        expect(dog.pending_pals).to_not include(@pal)
      end

      it "will destroy the pending_friendship" do
        dog = Dog.find(@dog.id)
        expect(dog.pending_friendships).to_not include(@pending_friendship)
      end
    end

  end
end
