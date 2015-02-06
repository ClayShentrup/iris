# == Schema Information
#
# Table name: pristine_examples
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :pristine_example do
    name 'MyString'
    description 'MyText'
  end
end
