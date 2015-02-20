# .
class MeasuresSearchResultsController < ApplicationController
  layout false
  def index
    @categories = []
    (1..3).each do |cat|
      @categories << {
        name: "category #{cat}",
        measures: (1..5).map { |m| "measure #{m}" },
      }
    end
  end
end
