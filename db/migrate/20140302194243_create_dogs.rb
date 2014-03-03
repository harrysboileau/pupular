class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :name
      t.timestamps
    end
  end
end
