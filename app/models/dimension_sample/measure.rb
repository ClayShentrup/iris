# == Schema Information
#
# Table name: dimension_sample_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  measure_id          :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require './app/models/provider'
require_relative '../dimension_sample'

module DimensionSample
  # Corresponds to a dataset like 7xux-kdpw, which has multiple rows per
  # provider.
  class Measure < ActiveRecord::Base
    validates :socrata_provider_id, presence: true
    validates :measure_id, presence: true
    validates :value, presence: true

    def self.data(measure_id:, providers:)
      matching_samples = where(measure_id: measure_id)
      providers.joins(<<-SQL)
        LEFT OUTER JOIN dimension_sample_measures
        ON dimension_sample_measures.socrata_provider_id =
        providers.socrata_provider_id
      SQL
        .merge(matching_samples)
        .pluck(:value, :name)
    end

    def self.create_or_update!(attributes)
      find_or_initialize_by(
        attributes.with_indifferent_access.slice(
          :socrata_provider_id,
          :measure_id,
        ),
      ).update_attributes!(attributes)
    end
  end
end

# Convenient alias for engineers on the command line
DSM = DimensionSample::Measure
