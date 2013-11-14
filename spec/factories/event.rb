FactoryGirl.define do
  factory :event do
    type { ["Walk", "Hangout"].sample }
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    location "351 W. Hubbard, Chicago, IL"
    date Date.today + 2.weeks
    start_time Time.now + 2.hours
  end
end
