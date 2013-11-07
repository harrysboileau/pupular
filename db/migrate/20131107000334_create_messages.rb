class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :type
      t.string :subject
      t.text :content
      t.integer :sender_id

      t.timestamps
    end
  end
end
