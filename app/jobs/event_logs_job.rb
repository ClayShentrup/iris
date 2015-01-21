# ActiveJob that continously fetches logs
class EventLogsJob < ActiveJob::Base
  queue_as :default

  def perform
    Reporting::Downloading::Manager.call
  end
end
