require 'reporting/downloading/get_event_log_marker'
require 'support/redis'

RSpec.describe Reporting::Downloading::GetEventLogMarker do
  include StubRedis

  let(:marker) do
    '3aec2e2f-flydata/app29267468_system/year=2014/month=09/' \
    'day=08/20140908-18.gz'
  end

  before do
    stub_redis
    REDIS.set(
      Reporting::Downloading::SetEventLogMarker::REDIS_KEY,
      marker,
    )
  end

  it 'persists the log marker forever' do
    expect(described_class.call).to eq marker
  end
end
