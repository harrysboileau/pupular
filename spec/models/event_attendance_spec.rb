require 'spec_helper'

describe EventAttendance do
  context "associations" do
    it { should belong_to(:attendees) }
    it { should belong_to(:attended_events) }
  end

  context "validations" do
    it { should validate_presence_of(:dog_id)}
    it { should validate_presence_of(:event_id)}
    it { should validate_uniqueness_of(:event_id).scoped_to(:dog_id) }
  end
end
