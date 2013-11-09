class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :username
      t.string :name
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token

      t.timestamps
    end
  end
end
