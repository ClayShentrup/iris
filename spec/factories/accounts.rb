# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_provider_id :integer
#  virtual_system_id   :integer
#  virtual_system_type :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

FactoryGirl.define do
  factory :account do
    skip_association_presence_validations

    trait :with_associations do
      association :virtual_system,
                  factory: [:hospital_system, :with_associations]
      after(:build) do |account|
        account.default_provider = account.virtual_system.providers.fetch(0)
      end
    end
  end
end
