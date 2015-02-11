# == Schema Information
#
# Table name: hospitals
#
#  id                 :integer          not null, primary key
#  name               :string           not null
#  zip_code           :string           not null
#  hospital_type      :string           not null
#  provider_id        :string           not null
#  state              :string           not null
#  city               :string           not null
#  hospital_system_id :integer
#

FactoryGirl.define do
  factory :hospital do
    sequence(:provider_id) { |n| n.to_s.rjust(6, '0') }
    name 'My Hospital'
    city 'San Francisco'
    state 'CA'
    zip_code '90210'
    hospital_type 'Childrens'

    trait :with_hospital_system do
      association :hospital_system
    end
  end
end
