class AddLongLatToEvent < ActiveRecord::Migration
  def change
  	    add_column :events, :lat, :string
  	    add_column :events, :long, :string
  end
end
