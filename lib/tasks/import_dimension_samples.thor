require 'thor/rails'
# Imports or updates existing dimension samples using Socrata.
class ImportDimensionSamples < Thor
  include Thor::Rails
  default_task :import

  desc 'import', 'import or update existing dimension samples using Socrata'
  def import
    ImportDimensionSamplesJob.perform_later
  end
end
