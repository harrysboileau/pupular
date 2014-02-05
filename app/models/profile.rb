class Profile < ActiveRecord::Base
  belongs_to :dog

  attr_accessible :age, :breed, :gender, :location, :image, :spayed, :size

  validates_presence_of :dog_id
  validates :gender, inclusion: { in: ["", "Male","Female"], message: "%w{value} is not a valid gender"}
  validates :size, inclusion: { in: ["", "Toy", "Small", "Medium", "Large", "Extra-large"], message: "%{value} is not a valid size" }



  mount_uploader :image, ImageUploader

  def self.size_options
    ["Toy", "Small", "Medium", "Large", "Extra-large"]
  end

  def self.gender_options
    ["Male", "Female"]
  end

  def not_empty?
    # why do you need to do this? why cant you just use activerecord validations?
    age || (breed && breed.present?) || (location.present?) || spayed || size.present? || gender.present?
  end

  def fixed
    spayed? ? "Yes" : "No"
  end
end
