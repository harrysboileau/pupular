FactoryGirl.define do
  factory :dog do
    name { Faker::Name.first_name }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "password"
  end
end
