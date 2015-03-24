require 'thor/rails'
# Imports or updates existing dimension samples using Socrata.
class RefreshDimensionSamples < Thor
  include Thor::Rails
  default_task :import

  desc 'import', 'import or update existing dimension samples using Socrata'
  def import
    PUBLIC_CHARTS_TREE.import_all
  end
end
