require 'active_job'

# ActiveJob that continously fetches logs
class EventLogsJob < ActiveJob::Base
  def perform
    Reporting::Downloading::Manager.call
  end
end
