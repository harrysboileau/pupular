class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "Dog", foreign_key: "creator_id"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances
  attr_accessible :creator_id, :description, :location, :title, :type
end

class Hangout < Event
end

class Walk < Event
end
