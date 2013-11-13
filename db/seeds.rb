# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

100.times do
	username = Faker::Internet.user_name
	password = "password"
	name = Faker::Name.name
	email = Faker::Internet.email
	dog = Dog.create(username: username, email: email, password: password, name: name )
  profile = Profile.new(breed:"Mutt", location:"Chicago", age:8, size:"Medium", gender:"Male", spayed:true)
  profile.image.store!(File.open(File.join(Rails.root.join('app', 'assets', 'images'), 'molar_bear.jpg')))
  dog.profile = profile
  profile.save
end

