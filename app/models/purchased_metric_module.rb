require './app/models/provider'

# We give customers access to metric modules that they've paid for.
class PurchasedMetricModule < ActiveRecord::Base
  belongs_to :accounts
end
