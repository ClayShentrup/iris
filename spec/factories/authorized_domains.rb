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
    sequence(:name) { |n| "mydomain#{n}.com" }
    association :account
  end
end
