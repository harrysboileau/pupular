class CreatePendingFriendships < ActiveRecord::Migration
  def change
    create_table :pending_friendships do |t|
      t.integer :dog_id
      t.integer :pending_friend_id

      t.timestamps
    end
  end
end
