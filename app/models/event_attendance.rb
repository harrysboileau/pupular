class EventAttendance < ActiveRecord::Base
  belongs_to :attendees, class_name: "Dog", foreign_key: "dog_id"
  belongs_to :attended_events, class_name: "Event", foreign_key: "event_id"

  validates_presence_of :dog_id, :event_id
  validates_uniqueness_of :event_id, scope: :dog_id
end
