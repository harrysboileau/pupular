class CreateQr < ActiveRecord::Migration
  def change
    create_table :qrs do |t|
      t.string :image

      t.timestamps
    end
  end
end
