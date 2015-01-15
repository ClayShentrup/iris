FactoryGirl.define do
  factory :hospital_system do
    sequence(:name) { |n| "Hospital System #{n}" }
  end
end
