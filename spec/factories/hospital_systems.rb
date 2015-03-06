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

  factory :hospital_system_with_provider, parent: :hospital_system do
    providers { create_list(:provider, 1) }
  end
end
