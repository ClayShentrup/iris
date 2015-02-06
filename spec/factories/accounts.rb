# == Schema Information
#
# Table name: pristine_examples
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :account do
    association :virtual_system, factory: [:hospital_system, :with_hospital]

    before(:create) do |account|
      account.default_hospital = account.virtual_system.hospitals.first
    end
  end
end
