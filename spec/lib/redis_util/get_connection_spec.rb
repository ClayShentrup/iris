require 'redis_util/get_connection'

RSpec.describe RedisUtil::GetConnection do
  let(:env) do
    {
      'REDIS_PROVIDER' => 'SOME_KEY',
      'SOME_KEY' => redis_url,
    }
  end
  let(:redis_url) { 'redis://host:port' }
  let!(:redis) { class_double('Redis') }
  let(:redis_instance) { instance_double('Redis') }

  before do
    stub_const('Redis', redis)
    stub_const('ENV', env)
    allow(Redis).to receive(:new).with(url: redis_url)
      .and_return(redis_instance)
  end

  specify { expect(described_class.call).to be redis_instance }
end
