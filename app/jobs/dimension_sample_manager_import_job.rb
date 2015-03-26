require 'active_job'

# ActiveJob that imports dimension samples
class DimensionSampleManagerImportJob < ActiveJob::Base
  def perform(dimension_samples:, model_attributes:, model_class_string:,
              rename_hash:, value_column_name:)
    Socrata::DimensionSampleImporter.call(
      dimension_samples: dimension_samples,
      model_attributes: model_attributes,
      model_class_string: model_class_string,
      rename_hash: rename_hash,
      value_column_name: value_column_name,
    )
  end
end
