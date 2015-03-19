# == Schema Information
#
# Table name: purchased_metric_modules
#
#  id               :integer          not null, primary key
#  account_id       :integer
#  metric_module_id :string
#

require './app/models/account'

# We give customers access to metric modules that they've paid for.
class PurchasedMetricModule < ActiveRecord::Base
  belongs_to :account
end
