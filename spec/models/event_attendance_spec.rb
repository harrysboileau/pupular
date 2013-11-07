require 'spec_helper'

describe EventAttendance do
let(:dog) { FactoryGirl.create(:dog) }
let(:event) { FactoryGirl.create(:event) }
  context "Associations" do
    it "will belong to attendee" do
      event_attendance = EventAttendance.create(dog_id: dog.id, event_id: event.id)
      expect(event_attendance.attendee).to eq(dog)
    end

    it "will belong to an event" do
      event_attendance = EventAttendance.create(dog_id: dog.id, event_id: event.id)
      expect(event_attendance.attended_events).to eq(Event.find(event.id))
    end
  end
end
