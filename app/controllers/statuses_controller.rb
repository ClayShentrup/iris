# Provides a single endpoint to be used for New Relic availability monitoring
class StatusesController < ApplicationController
  def show
    render text: SiteStatus.call
  end
end
