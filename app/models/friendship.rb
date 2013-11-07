class Friendship < ActiveRecord::Base
  belongs_to :dog, foreign_key: "dog_id"
  belongs_to :pal, foreign_key: "friend_id", class_name: "Dog"

  attr_accessible :dog_id, :friend_id

  validates_presence_of :dog_id, :friend_id
end
