class Profile < ActiveRecord::Base
  belongs_to :dog

  attr_accessible :age, :breed, :dog_id, :gender, :location, :photo, :spayed

  validates :size, inclusion: { in: ["toy", "small", "medium", "large", "extra-large"], message: "%{value} is not a valid size" }
end
