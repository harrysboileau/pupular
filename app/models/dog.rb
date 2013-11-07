class Dog < ActiveRecord::Base
  has_many :friendships, foreign_key: "dog_id", class_name: "Friendship"
  has_many :pals, through: :friendships
  has_many :pending_friendships, foreign_key: "dog_id", class_name: "PendingFriendship"
  has_many :pending_pals, through: :pending_friendships
  has_one :profile
  has_many :sent_messages, foreign_key: "sender_id", class_name: "Message"
  has_many :inbox_messages
  has_many :received_messages, through: :inbox_messages
  has_many :events, foreign_key: "creator_id"
  has_many :event_attendances
  has_many :attended_events, through: :event_attendances

  attr_accessible :email, :password, :username
  has_secure_password
end
