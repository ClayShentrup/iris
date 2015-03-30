require 'reporting/daily_page_view_metrics_report'
require './spec/support/fixture_data/log_data'

RSpec.describe Reporting::DailyPageViewMetricsReport do
  let(:report) { described_class.call(log_lines) }
  let(:log_lines) do
    [
      learn_view_data,
      learn_view_data,
      untracked_data,
    ]
  end
  let(:learn_route) { 'metric_samples/:metric_sample/learn' }
  let(:learn_view_data) { LogData.page_view(learn_route) }
  let(:untracked_data) { LogData.dummy_event(learn_route) }

  it 'returns the routes hit today and their counts' do
    expect(report).to eq(
      learn_route => 2,
    )
  end
end
