require 'active_support/core_ext/numeric/time'
require 'active_support/core_ext/date/calculations'

# Returns a DateTime object in the client's timezone, defined in application.rb.
module Reporting
  ReportDayInClientTimeZone = Struct.new(:report_date_string) do
    def self.call(*args)
      new(*args).call
    end

    def call
      report_day_start_in_client_time_zone...(
        report_day_start_in_client_time_zone.tomorrow
      )
    end

    private

    def report_day_start_in_client_time_zone
      @report_day_start_in_client_time_zone ||=
      if report_date_string.present?
        client_time_zone.parse(report_date_string)
      else
        client_time_zone.now.yesterday.beginning_of_day
      end
    end

    def client_time_zone
      APP_CONFIG.client_time_zone
    end
  end
end
