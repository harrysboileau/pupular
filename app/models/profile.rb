class Profile < ActiveRecord::Base
  belongs_to :dog

  attr_accessible :age, :breed, :gender, :location, :photo, :spayed

  validates_presence_of :age, :breed, :dog_id, :gender, :location, :photo, :spayed, :size
  validates :gender, inclusion: { in: ["male","female"], message: "%w{value} is not a valid gender"}
  validates :size, inclusion: { in: ["toy", "small", "medium", "large", "extra-large"], message: "%{value} is not a valid size" }
end
