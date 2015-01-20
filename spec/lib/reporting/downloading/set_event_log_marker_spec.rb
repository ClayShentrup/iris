require 'rails_helper'

RSpec.describe Reporting::Downloading::SetEventLogMarker do
  let(:marker_prefix) do
    '3aec2e2f-flydata/app29267468_system/year=2014/month=09/'
  end
  let(:marker) do
    "#{marker_prefix}day=08/20140908-18.gz"
  end

  def time_to_live
    $redis_pool.with do |redis|
      redis.ttl(described_class.const_get(:REDIS_KEY))
    end
  end

  it 'persists the log marker forever' do
    described_class.call(marker)
    expect(time_to_live).to eq(-1) # -1 means forever
  end
end
