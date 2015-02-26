# provides a page with the latest activity related with the current user
class NewsItemsController < ApplicationController
  def index
    @custom_feedback_bar = true
  end
end
