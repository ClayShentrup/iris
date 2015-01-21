require 'rails_helper'
require 'timecop'

RSpec.describe EventLogsJob, type: :job do
  let(:now) { Time.zone.parse('2014-09-24 16:30:53 -0700') }

  before do
    allow(Reporting::Downloading::Manager).to receive(:call)
  end

  def work
    Timecop.freeze(now.to_s) do
      described_class.perform_now
    end
  end

  it 'fetches the logs' do
    expect(Reporting::Downloading::Manager).to receive(:call)
    work
  end
end
