# == Schema Information
#
# Table name: hospital_systems
#
#  id   :integer          not null, primary key
#  name :string           not null
#

FactoryGirl.define do
  factory :hospital_system do
    sequence(:name) { |n| "Hospital System #{n}" }
  end

  factory :hospital_system_with_hospital, parent: :hospital_system do
    hospitals { create_list(:hospital, 1) }
  end
end
