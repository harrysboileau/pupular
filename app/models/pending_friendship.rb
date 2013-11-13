class PendingFriendship < ActiveRecord::Base
  belongs_to :dog, foreign_key: "dog_id"
  belongs_to :pending_pal, class_name: "Dog", foreign_key: "pending_friend_id"

  validates_presence_of :dog_id, :pending_friend_id
  validates_uniqueness_of :pending_friend_id, scope: :dog_id


  def approve!
    friendship = Friendship.new
    friendship.dog = dog
    friendship.friend = pending_friend
    friendship.save!
    friendship = Friendship.new
    friendship.dog = pending_friend
    friendship.friend = dog
    friendship.save!
    self.destroy # I wouldnt recommend destroying. Instead have a boolean column
                 # :processed or :completed that you toggle to deactivate pending friendships
  end
end
