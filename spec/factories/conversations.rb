# == Schema Information
#
# Table name: conversations
#
#  id                :integer          not null, primary key
#  provider_id       :integer
#  author_id         :integer
#  node_id_component :string           not null
#  title             :string           not null
#  description       :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :conversation do
    skip_association_validations
    sequence(:title) { |n| "Conversation Title #{n}" }
    description 'My Description'
    node_id_component 'patient-safety-composite'

    trait :with_associations do
      association :provider
      association :user
    end
  end
end
