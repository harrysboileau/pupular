class Invitation < ActiveRecord::Base

  belongs_to :dog, foreign_key: "dog_id"
  belongs_to :invited_pals, class_name: "Dog", foreign_key: "invited_pal_id"
  belongs_to :pending_events, class_name: "Event", foreign_key: "event_id"

  validates_presence_of :dog_id, :invited_pal_id, :event_id
  validates_uniqueness_of :invited_pal_id, scope: [:dog_id, :event_id]

end
