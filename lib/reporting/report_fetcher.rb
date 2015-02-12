module Reporting
  # Fetch log lines from the db and use report class to process them
  module ReportFetcher
    def self.call(report_date_string:, report_class:)
      report_day_in_client_time_zone = ReportDayInClientTimeZone.call(
        report_date_string,
      )
      log_lines = LogLine.where(
        logged_at: report_day_in_client_time_zone,
      )
      log_lines_data = log_lines.map(&:data)
      {
        date: report_day_in_client_time_zone.first.to_date,
        report: report_class.call(log_lines_data),
      }
    end
  end
end
