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
end
