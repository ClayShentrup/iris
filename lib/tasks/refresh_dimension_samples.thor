require 'thor/rails'

# Alias for import_dimension_samples
class RefreshDimensionSamples < Thor
  include Thor::Rails
  default_task :refresh

  desc 'refresh', 'Alias for import_dimension_samples'
  def refresh
    invoke :import_dimension_samples
  end
end
