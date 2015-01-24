# Provides a single endpoint to be used for New Relic availability monitoring
class StatusesController < ApplicationController
  skip_before_action :authenticate_user!

  def show
    render text: SiteStatus.call
  end
end
