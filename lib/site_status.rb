# Returns the status for the Website's dependencies
class SiteStatus
  class << self
    delegate :call, to: :new
  end

  def call
    {
      overall_status: overall_status,
      checks: {
        database_status: database_status,
      },
    }
  end

  private

  def overall_status
    all_checks_pass? ? 'All is well' : 'Something went wrong'
  end

  def all_checks_pass?
    database_status == 'OK'
  end

  def database_status
    @database_status ||= 'OK' if query_database
  rescue => e
    e.message
  end

  def query_database
    ActiveRecord::Base.connection.execute('SELECT NOW();')
  end
end
