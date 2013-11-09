class Profile < ActiveRecord::Base
  belongs_to :dog

  attr_accessible :age, :breed, :gender, :location, :photo, :spayed, :size

  validates_presence_of :dog_id
  validates :gender, inclusion: { in: ["", "Male","Female"], message: "%w{value} is not a valid gender"}
  validates :size, inclusion: { in: ["", "Toy", "Small", "Medium", "Large", "Extra-large"], message: "%{value} is not a valid size" }

  def self.size_options
    ["Toy", "Small", "Medium", "Large", "Extra-large"]
  end

  def self.gender_options
    ["Male", "Female"]
  end

  def not_empty?
    age != nil || (breed != nil && photo != "") || (location != nil && photo != "") || (photo != nil && photo != "") || spayed != nil || (size != nil && size != "") || (gender != nil && gender != "")
  end
end
