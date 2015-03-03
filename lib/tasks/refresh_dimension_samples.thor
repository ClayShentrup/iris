require 'thor/rails'
# Imports or updates existing dimension samples using Socrata.
class RefreshDimensionSamples < Thor
  include Thor::Rails
  default_task :refresh

  desc 'refresh', 'import or update existing dimension samples using Socrata'
  def refresh
    PUBLIC_CHARTS_TREE.refresh
  end
end
