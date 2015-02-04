# Defines the namespace for related dimension models. Required by ActiveRecord.
module DimensionSample
  def self.table_name_prefix
    'dimension_sample_'
  end
end
