class Profile < ActiveRecord::Base
  belongs_to :dog

  attr_accessible :age, :breed, :gender, :location, :image, :spayed, :size

  validates_presence_of :dog_id
  validates :gender, inclusion: { in: ["", "Male","Female"], message: "%w{value} is not a valid gender"}
  validates :size, inclusion: { in: ["", "Toy", "Small", "Medium", "Large", "Extra-large"], message: "%{value} is not a valid size" }



  mount_uploader :image, ImageUploader

  # These should probably be constants instead of methods.
  def self.size_options
    ["Toy", "Small", "Medium", "Large", "Extra-large"]
  end

  def self.gender_options
    ["Male", "Female"]
  end

  # o lawd
  def not_empty?
    age || (breed && breed.present?) || (location.present?) || spayed || size.present? || gender.present?
  end

  # should probably use decorators and extract this logic to a profile decorator
  # (and maybe above also)
  def fixed
    if spayed
      "Yes"
    else
      "No"
    end
  end
end
