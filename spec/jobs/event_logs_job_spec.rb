require './app/jobs/event_logs_job'

RSpec.describe EventLogsJob do
  def work
    Timecop.freeze('2014-09-24 16:30:53 -0700') do
      described_class.perform_now
    end
  end

  before do
    stub_const('Reporting::Downloading::Manager', double)
  end

  it 'fetches the logs' do
    expect(Reporting::Downloading::Manager).to receive(:call)
    work
  end
end
