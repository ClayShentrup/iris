# == Schema Information
#
# Table name: dimension_sample_multi_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  measure_id          :string           not null
#  column_name         :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  dataset_id          :string           not null
#

require_relative '../dimension_sample'

module DimensionSample
  # Corresponds to a dataset like 7xux-kdpw, which has multiple rows per
  # provider.
  class MultiMeasure < ActiveRecord::Base
    validates :dataset_id, presence: true
    validates :socrata_provider_id, presence: true
    validates :measure_id, presence: true
    validates :column_name, presence: true
    validates :value, presence: true
  end
end
