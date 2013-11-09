class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :breed
      t.string :location
      t.integer :age
      t.string :size
      t.string :gender
      t.boolean :spayed
      t.integer :dog_id
      t.string :image
      t.timestamps
    end
  end
end

#, :html => {:multipart => true}
#<%= f.file_field :image %><br>
