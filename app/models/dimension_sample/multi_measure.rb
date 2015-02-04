require_relative '../dimension_sample'

module DimensionSample
  # Corresponds to a dataset like 7xux-kdpw, which has multiple rows per
  # provider.
  class MultiMeasure < ActiveRecord::Base
    validates :provider_id, presence: true
    validates :measure_id, presence: true
    validates :column_name, presence: true
    validates :value, presence: true
  end
end
