class EventAttendance < ActiveRecord::Base
  belongs_to :attendee, class_name: "Dog", foreign_key: "dog_id"
  belongs_to :attended_events, class_name: "Event", foreign_key: "event_id"

  attr_accessible :dog_id, :event_id
end
