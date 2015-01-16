# Provides a single endpoint to be used for New Relic availability monitoring
class StatusesController < ApplicationController
  def show
    database_status = can_connect_to_db? ? 'OK' : 'Not OK'
    render json: { database_status: database_status }
  end

  private

  def can_connect_to_db?
    begin
      ActiveRecord::Base.connection.execute('SELECT NOW();')
    rescue
      false
    end
    true
  end
end
