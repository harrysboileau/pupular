require 'spec_helper'

describe Invitation do
  let(:dog) {create(:dog)}
  let(:pal) {create(:dog)}
  let(:event) { build(:event)}

  context 'associations' do
    it { should belong_to(:dog) }
    it { should belong_to(:invited_pals) }
    it { should belong_to(:pending_events) }
  end

  context 'validations' do
    it { should validate_presence_of(:dog_id) }
    it { should validate_presence_of(:invited_pal_id) }
    it { should validate_presence_of(:event_id) }
    it "it will validate uniqueness of event_id scoped to dog_id, event_id" do
      dog.events << event
      invitation = Invitation.new
      invitation.dog = dog
      invitation.invited_pal_id = pal.id
      invitation.event_id = event.id
      invitation.save
      @invitation = Invitation.new
      @invitation.dog = dog
      @invitation.invited_pal_id = pal.id
      @invitation.event_id = event.id
      @invitation.save
      expect(@invitation.errors.messages[:invited_pal_id].to_s).to match(/already been take/)
    end
  end
end




