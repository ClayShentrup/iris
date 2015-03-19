require 'active_record_no_rails_helper'
require './app/models/purchased_metric_module'

RSpec.describe PurchasedMetricModule do
  subject { build_stubbed(described_class) }

  it { is_expected.to belong_to :account }
end
