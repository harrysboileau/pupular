class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type
      t.string :title
      t.text :description
      t.string :location
      t.datetime :start_time
      t.datetime :end_time

      t.integer :creator_id

      t.timestamps
    end
  end
end
