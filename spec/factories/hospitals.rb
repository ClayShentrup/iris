# == Schema Information
#
# Table name: hospitals
#
#  id                 :integer          not null, primary key
#  name               :string
#  zip_code           :string
#  hospital_type      :string
#  provider_id        :string
#  state              :string
#  city               :string
#  hospital_system_id :integer
#

FactoryGirl.define do
  factory :hospital do
    sequence(:provider_id) { |n| n.to_s.rjust(6, '0') }
    name 'My Hospital'
    city 'San Francisco'
    state 'CA'
    hospital_system

    trait :without_hospital_system do |hospital|
      hospital.hospital_system nil
    end
  end
end
