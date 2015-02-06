# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_hospital_id :integer          not null
#  virtual_system_id   :integer          not null
#  virtual_system_type :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :account do
    association :virtual_system, factory: [:hospital_system, :with_hospital]

    before(:create) do |account|
      account.default_hospital = account.virtual_system.hospitals.first
    end
  end
end
