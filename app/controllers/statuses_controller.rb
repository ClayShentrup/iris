# Provides a single endpoint to be used for New Relic availability monitoring
class StatusesController < ApplicationController
  def show
    render json: { database_status: database_status }
  end

  private

  def database_status
    'OK' if db_connect
  rescue => e
    e.message
  end

  def db_connect
    ActiveRecord::Base.connection.execute('SELECT NOW();')
  end
end
