# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

def random_image
  File.open(random_image_url)
end

def random_image_url
    File.join(Rails.root.join('app', 'assets', 'images'), "#{random_number}.jpg")
end

def random_number
    numbers = (1..10).to_a
    numbers.map! { |x| x.to_s }
    numbers.sample
end

100.times do
	username = Faker::Internet.user_name
	password = "password"
	name = Faker::Name.name
	email = Faker::Internet.email
	dog = Dog.create(username: username, email: email, password: password, name: name )
  profile = Profile.new(breed:"Mutt", location:"Chicago", age:8, size:"Medium", gender:"Male", spayed:true, image: random_image)
  dog.profile = profile
  profile.save
end

