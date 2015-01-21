require 'thor/rails'

# Thor runner for report aggregation
class ReportingRunner < Thor
  include Thor::Rails
  default_task :fetch_reporting_log
  desc :fetch_reporting_log, 'Runs reports for page metrics'

  def fetch_reporting_log
    say 'Fetching report logs...'
    EventLogsWorker.new.perform
    say 'done.'
  end
end
