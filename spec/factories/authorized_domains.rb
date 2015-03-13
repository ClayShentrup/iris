FactoryGirl.define do
  factory :authorized_domain do
    sequence(:name) { |n| "mydomain#{n}.com" }
    association :account
  end
end
