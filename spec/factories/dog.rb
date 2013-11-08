FactoryGirl.define do
  factory :dog do
    name { ["BobbieMcGee", "Fido", "Sprinkles"].sample }
    username { Faker::Internet.user_name }
    email { Faker::Internet.email }
    password "password"
  end
end
