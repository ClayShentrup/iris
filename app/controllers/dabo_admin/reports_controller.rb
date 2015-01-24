module DaboAdmin
  # Controller for Reporting panel
  class ReportsController < ApplicationController
    def index
      report_and_date = Reporting::ReportFetcher.call(
        report_date_string: params.fetch(:logged_at, nil),
        report_class: Reporting::DailyPageViewMetricsReport,
        )
      @report = report_and_date.fetch(:report)
      @date = report_and_date.fetch(:date)
    end
  end
end
