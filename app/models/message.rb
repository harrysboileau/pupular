class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "Dog"
  has_many :inbox_messages
  has_many :recipients, through: :inbox_messages
  attr_accessible :content, :subject, :type

  validates_presence_of :content, :subject, :sender_id, :type
  validates :type, inclusion: { in: ["Automated", "Personal"], message: "%{value} is not a valid message type" }
end

class Automated < Message
end

class Personal < Message
end



