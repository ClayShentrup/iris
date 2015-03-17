# == Schema Information
#
# Table name: purchased_metric_modules
#
#  id               :integer          not null, primary key
#  account_id       :integer
#  metric_module_id :string
#

require './app/models/purchased_metric_module'

FactoryGirl.define do
  factory :purchased_metric_module
end
