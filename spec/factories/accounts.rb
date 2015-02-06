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
    association :virtual_system, factory: :hospital_system
    association :default_hospital, factory: :hospital

    before(:create) do |account|
      account.virtual_system.hospitals << account.default_hospital
    end
  end
end
