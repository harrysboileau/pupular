require 'spec_helper'

describe Dog do
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
    it { should validate_presence_of(:email)}
    it { should validate_uniqueness_of(:email) }
    it { should_not allow_value("zack").for(:email) }
    it { should validate_presence_of(:username)}
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:password)}
    it { should_not allow_value("passw").for(:password)}
    it { should_not allow_value("passwordpassw").for(:password)}
    it { should validate_presence_of(:name)}
  end

  context "methods" do
    describe "#accept_pal" do
    let(:dog) { Dog.create(attributes_for(:dog)) }
    let(:pal) { Dog.create(attributes_for(:dog)) }
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
