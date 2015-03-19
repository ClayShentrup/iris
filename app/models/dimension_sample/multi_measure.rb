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

require './app/models/provider'
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

    def self.data(column_name:, dataset_id:, measure_id:, providers:)
      matching_samples = where(
        dataset_id: dataset_id,
        column_name: column_name,
        measure_id: measure_id,
      )
      providers.joins(<<-SQL)
        LEFT JOIN dimension_sample_multi_measures
        ON dimension_sample_multi_measures.socrata_provider_id =
        providers.socrata_provider_id
      SQL
        .merge(matching_samples)
        .pluck(:value)
    end

    def self.create_or_update!(attributes)
      find_or_initialize_by(
        attributes.slice(
          :column_name,
          :dataset_id,
          :socrata_provider_id,
          :measure_id,
        ),
      ).update_attributes!(attributes)
    end
  end
end

# Convenient alias for engineers on the command line
DSMM = DimensionSample::MultiMeasure
