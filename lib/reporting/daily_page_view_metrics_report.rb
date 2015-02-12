require 'active_support/core_ext/object/blank'

# Takes logline data from DB and returns a hash used to generate the report view
module Reporting
  DailyPageViewMetricsReport = Struct.new(:log_lines_data) do
    def self.call(*args)
      new(*args).call
    end

    def call
      Hash[
      valid_routes.group_by(&:to_s).map do |route, occurences|
        [route, occurences.count]
      end
      ]
    end

    private

    def valid_routes
      routes.select(&:present?)
    end

    def routes
      page_view_data.map { |data| data.fetch('properties').fetch('route') }
    end

    def page_view_data
      log_lines_data.select { |data| data.fetch('event') == 'Page View' }
    end
  end
end
