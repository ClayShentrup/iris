FactoryGirl.define do
  factory :hospital do
    sequence(:provider_id) { |n| n.to_s.rjust(6, '0') }
  end
end
