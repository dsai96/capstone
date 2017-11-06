FactoryGirl.define do
  factory :semester do
    season     { Faker::Season.season }
    year        { Faker::Yeas.year }
  end
end
