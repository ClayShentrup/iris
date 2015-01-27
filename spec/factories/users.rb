FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@factory.com" }
    password 'password'
    before(:create, &:skip_confirmation!)

    factory :dabo_admin do
      is_dabo_admin true
    end
  end
end
