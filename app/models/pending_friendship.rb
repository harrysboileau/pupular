class PendingFriendship < ActiveRecord::Base
  belongs_to :dog, foreign_key: "dog_id"
  belongs_to :pending_pal, class_name: "Dog", foreign_key: "pending_friend_id"

  validates_presence_of :dog_id, :pending_friend_id
  validates_uniqueness_of :pending_friend_id, scope: :dog_id
end
