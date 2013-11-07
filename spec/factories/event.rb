FactoryGirl.define do
  factory :event do
    type { ["Walk", "Hangout"].sample }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    location { Faker::Lorem.sentence }
    start_time DateTime.now + 2.weeks
    end_time DateTime.now + 2.weeks
  end
end
