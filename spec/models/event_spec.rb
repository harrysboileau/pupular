require 'spec_helper'

describe Event do

  context 'associations' do
    it { should belong_to(:creator) }
    it { should have_many(:event_attendances) }
    it { should have_many(:attendees) }
  end

  context 'validations' do
    it { should validate_presence_of(:creator_id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:type) }
    it { should ensure_inclusion_of(:type).in_array(["Walk", "Hangout"]) }
  end
end
