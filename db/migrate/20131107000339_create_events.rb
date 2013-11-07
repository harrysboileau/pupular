class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :title
      t.text :description
      t.string :location
      t.integer :creator_id

      t.timestamps
    end
  end
end
