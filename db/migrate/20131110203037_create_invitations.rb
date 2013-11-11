class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :dog_id
      t.integer :invited_pal_id
      t.integer :event_id
      t.boolean :declined, default: false

      t.timestamps
    end
  end
end
