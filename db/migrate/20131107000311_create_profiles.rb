class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :photo
      t.string :breed
      t.string :location
      t.integer :age
      t.string :size
      t.string :gender
      t.boolean :spayed
      t.integer :dog_id

      t.timestamps
    end
  end
end
