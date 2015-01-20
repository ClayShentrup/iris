# Sidekiq worker that continuously fetches logs
class EventLogsWorker
  include Sidekiq::Worker

  def perform
    Reporting::Downloading::Manager.call
  end
end
