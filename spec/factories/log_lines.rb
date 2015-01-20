# == Schema Information
#
# Table name: log_lines
#
#  id                :integer          not null, primary key
#  heroku_request_id :string
#  data              :text
#  logged_at         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :log_line do
    heroku_request_id 'MyString'
    data 'MyText'
    logged_at '2015-01-19 16:05:00'
  end
end
