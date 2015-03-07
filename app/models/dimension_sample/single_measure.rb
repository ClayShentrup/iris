# == Schema Information
#
# Table name: dimension_sample_single_measures
#
#  id                  :integer          not null, primary key
#  socrata_provider_id :string           not null
#  dataset_id          :string           not null
#  column_name         :string           not null
#  value               :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require_relative '../dimension_sample'
module DimensionSample
  # Corresponds to a dataset like yq43-i98g, which has one line per provider.
  class SingleMeasure < ActiveRecord::Base
    validates :dataset_id, presence: true
    validates :socrata_provider_id, presence: true
    validates :column_name, presence: true
    validates :value, presence: true

    def self.data(dataset_id:, options:, providers:)
      where(
        dataset_id: dataset_id,
        column_name: options.fetch(:column_name),
      )
        .joins(<<-JOIN_QUERY)
          LEFT JOIN providers
          ON dimension_sample_single_measures.socrata_provider_id =
          providers.socrata_provider_id
        JOIN_QUERY
        .merge(providers)
        .pluck(:value)
    end

    def self.create_or_update!(attributes)
      find_or_initialize_by(
        attributes.slice(:column_name, :dataset_id, :socrata_provider_id),
      ).update_attributes!(attributes)
    end
  end
end

# Convenient alias for engineers on the command line
DSSM = DimensionSample::SingleMeasure
