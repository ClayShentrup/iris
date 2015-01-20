require 'rails_helper'

RSpec.describe Reporting::DailyPageViewMetricsReport do
  let(:report) { described_class.call(log_lines) }

  let(:log_lines) do
    [
      learn_view_line_1,
      learn_view_line_2,
      untracked_event_line,
      activity_view_line,
    ]
  end
  let(:learn_route) { 'metric_samples/:metric_sample/learn' }
  let(:activities_route) do
    'news/activity_filters/:activity_filter/activities'
  end

  let(:learn_view_data) { LogData.page_view(learn_route) }
  let(:activity_view_data) { LogData.page_view(activities_route) }
  let(:untracked_data) { LogData.dummy_event(learn_route) }

  let!(:learn_view_line_1) do
    log_line(learn_view_data)
  end

  let!(:learn_view_line_2) do
    log_line(learn_view_data)
  end

  let!(:untracked_event_line) do
    log_line(untracked_data)
  end

  let!(:activity_view_line) do
    log_line(activity_view_data)
  end

  def log_line(data)
    FactoryGirl.build_stubbed(:log_line, data: data)
  end

  it 'returns the routes hit today and their counts' do
    expect(report).to eq(
      learn_route => 2,
      activities_route => 1,
    )
  end
end
