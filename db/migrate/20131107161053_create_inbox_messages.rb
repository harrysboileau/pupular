class CreateInboxMessages < ActiveRecord::Migration
  def change
    create_table :inbox_messages do |t|
      t.integer :dog_id
      t.integer :message_id

      t.timestamps
    end
  end
end
