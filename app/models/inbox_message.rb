class InboxMessage < ActiveRecord::Base
  belongs_to :received_message, class_name: "Message", foreign_key: "message_id"
  belongs_to :recipient, class_name: "Dog", foreign_key: "dog_id"

  attr_accessible :dog_id, :message_id
end
