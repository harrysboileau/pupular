require 'spec_helper'

describe Event do
  let(:dog) { FactoryGirl.create(:dog) }
  let(:attendee) { FactoryGirl.create(:dog) }
  let(:event) {Event.create(FactoryGirl.attributes_for(:event) )}

  it "will have a creator" do
    dog.events << event
    expect(event.creator).to eq(dog)
  end

  it "will have event_attendance records" do
    dog.attended_events << event
    expect(event.event_attendances).to include(EventAttendance.find_by_dog_id(dog.id))

  end

  it "will have attendees" do
    dog.attended_events << event
    expect(event.attendees).to include(dog)
  end

end
