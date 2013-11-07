FactoryGirl.define do
  factory :dog do
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "password"
  end
end
