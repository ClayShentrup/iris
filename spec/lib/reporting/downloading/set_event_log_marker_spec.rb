require 'reporting/downloading/set_event_log_marker'
require 'support/redis'

RSpec.describe Reporting::Downloading::SetEventLogMarker do
  include StubRedis

  let(:marker_prefix) do
    '3aec2e2f-flydata/app29267468_system/year=2014/month=09/'
  end
  let(:event_log_marker) do
    "#{marker_prefix}day=08/20140908-18.gz"
  end

  def time_to_live
    REDIS.ttl(described_class.const_get(:REDIS_KEY))
  end

  it 'persists the log marker forever' do
    stub_redis
    described_class.call(event_log_marker)
    expect(time_to_live).to eq(-1) # -1 means forever
  end
end
