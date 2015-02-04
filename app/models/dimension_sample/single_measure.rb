require_relative '../dimension_sample'
module DimensionSample
  # Corresponds to a dataset like yq43-i98g, which has one line per provider.
  class SingleMeasure < ActiveRecord::Base
    validates :dataset_id, presence: true
    validates :provider_id, presence: true
    validates :column_name, presence: true
    validates :value, presence: true
  end
end
