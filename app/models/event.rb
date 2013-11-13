class Event < ActiveRecord::Base
  belongs_to :creator, class_name: "Dog", foreign_key: "creator_id"
  has_many :event_attendances
  has_many :attendees, through: :event_attendances
  has_many :invitations
  has_many :invited_pals, through: :invitations

  validates_presence_of :creator_id, :title, :description, :location, :type, :start_time, :date
  validates :type, inclusion: { in: ["Walk", "Hangout"], message:"%{value} is not a type" }

  attr_accessible :description, :location, :title, :type, :start_time, :date

  # this method scares me, can you refactor it for redability?
  def time
    hour = self.start_time.strftime("%H").to_i
    if hour < 12
      self.start_time.strftime("%H:%M AM")
    else
      hour -= 12
      hour.to_s + (self.start_time.strftime(":%M PM"))
    end
  end
end

# it'd be better to move these classes into their own files
class Hangout < Event
end

class Walk < Event
end
