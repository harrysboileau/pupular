class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "Dog", foreign_key: "creator_id"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances

  validates_presence_of :creator_id, :title, :description, :location, :type, :start_time, :end_time
  validates :type, inclusion: { in: ["Walk", "Hangout"], message:"%{value} is not a type" }

  attr_accessible :description, :location, :title, :type, :start_time, :end_time
end
class Hangout < Event
end

class Walk < Event
end
