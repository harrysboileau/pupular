FactoryGirl.define do
  factory :profile do
    # photo "http://localhost:3000"
    breed { Faker::Lorem.word }
    location "341 W. Hubbard St."
    age { (1..10).to_a.sample }
    size { ["toy", "small", "medium", "large", "extra-large"].sample }
    gender { ["male", "female"].sample }
    spayed { [true,false].sample }
  end
end
