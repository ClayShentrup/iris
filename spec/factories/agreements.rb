# == Schema Information
#
# Table name: agreements
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  item_type  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :agreement do
    skip_association_presence_validations

    trait :with_associations do
      association :user
      association :item, factory: :comment
    end
  end
end
