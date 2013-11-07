class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "Dog"
  has_many :inbox_messages
  has_many :recipients, through: :inbox_messages
  attr_accessible :content, :sender_id, :subject, :type
end

class Automated < Message
end

class Personal < Message
end
