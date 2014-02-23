class PendingFriendship < ActiveRecord::Base
  belongs_to :dog, foreign_key: "dog_id"
  belongs_to :pending_pal, class_name: "Dog", foreign_key: "pending_friend_id"

  validates_presence_of :dog_id, :pending_friend_id
  validates_uniqueness_of :pending_friend_id, scope: :dog_id


  # Way too long + nigh duplicated code. Extract to one method
  # we can call twice. Can we use create! instead of new/save?
  def approve!
    friendship = Friendship.new
    friendship.dog_id = self.dog_id
    friendship.friend_id = self.pending_friend_id
    friendship.save!
    friendship = Friendship.new
    friendship.dog_id = self.pending_friend_id
    friendship.friend_id = self.dog_id
    friendship.save!
    self.destroy
  end
end
