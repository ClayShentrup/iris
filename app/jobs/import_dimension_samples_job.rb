require 'active_job'

# ActiveJob that continously fetches Dimension Samples
class ImportDimensionSamplesJob < ActiveJob::Base
  def perform
    PUBLIC_CHARTS_TREE.import_all
  end
end
