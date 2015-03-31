# == Schema Information
#
# Table name: authorized_domains
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  account_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :authorized_domain do
    skip_association_presence_validations

    sequence(:name) { |n| "mydomain#{n}.com" }

    trait :with_associations do
      association :account, :with_associations
    end
  end
end
