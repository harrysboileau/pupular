class InboxMessage < ActiveRecord::Base
  belongs_to :received_message, class_name: "Message", foreign_key: "message_id"
  belongs_to :recipient, class_name: "Dog", foreign_key: "dog_id"

  validates_presence_of :dog_id, :message_id
  validates_uniqueness_of :message_id, scope: :dog_id
end
