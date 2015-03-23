# == Schema Information
#
# Table name: conversations
#
#  id                :integer          not null, primary key
#  provider_id       :integer
#  user_id           :integer
#  node_component_id :string           not null
#  title             :string           not null
#  description       :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :conversation do
    sequence(:title) { |n| "Converstaion Title #{n}" }
    description 'My Description'
    node_component_id 'patient-safety-composite'
    skip_association_validations true

    trait :with_associations do
      association :provider
      association :user
    end
  end
end
