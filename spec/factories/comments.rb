# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  content         :text             not null
#  author_id       :integer
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    sequence(:content) { |n| "Comment #{n}" }
    skip_association_presence_validations

    trait :with_associations do
      association :author
      association :conversation
    end
  end
end
