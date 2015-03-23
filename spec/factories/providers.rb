# == Schema Information
#
# Table name: providers
#
#  id                  :integer          not null, primary key
#  name                :string           not null
#  zip_code            :string           not null
#  hospital_type       :string           not null
#  socrata_provider_id :string           not null
#  state               :string           not null
#  city                :string           not null
#  hospital_system_id  :integer
#

FactoryGirl.define do
  factory :provider do
    sequence(:socrata_provider_id) { |n| n.to_s.rjust(6, '0') }
    sequence(:name) { |n| "My Provider #{n}" }
    city 'SAN FRANCISCO'
    state 'CA'
    zip_code '90210'
    hospital_type 'Childrens'
  end

  trait :with_associations do
    association :hospital_system
  end
end
