# Renders the styleguide view(s)
class StyleguidesController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    render layout: 'styleguide'
  end
end
