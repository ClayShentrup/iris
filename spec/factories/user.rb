FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password 'password'
  end
end
