FactoryGirl.define do
  factory :message do
    type { ["Automated", "Personal"].sample }
    subject { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
  end
end


