require 'rails_helper'
require 'timecop'

RSpec.describe EventLogsWorker, sidekiq: :inline do
  let(:now) { Time.zone.parse('2014-09-24 16:30:53 -0700') }

  before do
    allow(Reporting::Downloading::Manager).to receive(:call)
  end

  def work
    Timecop.freeze(now.to_s) do
      described_class.perform_async
    end
  end

  it 'fetches the logs' do
    expect(Reporting::Downloading::Manager).to receive(:call)
    work
  end
end
