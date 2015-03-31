require 'active_support/core_ext/string/exclude'
require_relative 'rename_attributes'

# .
module Socrata
  # Imports Socrata dimension samples
  DimensionSampleImporter = Struct.new(:dimension_samples, :model_attributes,
                                       :model_class, :rename_hash,
                                       :value_column_name) do
    def self.call(dimension_samples:, model_attributes:, model_class:,
                  rename_hash:, value_column_name:)
      new(
        dimension_samples,
        model_attributes,
        model_class,
        rename_hash,
        value_column_name.to_s,
      ).call
    end

    def call
      processed_dimension_samples.each do |dimension_sample_attributes|
        model_class.create_or_update!(dimension_sample_attributes)
      end
    end

    private

    def processed_dimension_samples
      sanitized_dimension_samples.map do |dimension_sample|
        dimension_sample.merge(model_attributes)
      end
    end

    def sanitized_dimension_samples
      renamed_dimension_samples.select do |dimension_sample|
        dimension_sample.key?('value') and
        dimension_sample.fetch('value').exclude?('Not Available')
      end
    end

    def renamed_dimension_samples
      dimension_samples.map do |dimension_sample_attributes|
        RenameAttributes.call(
          attributes: dimension_sample_attributes,
          rename_hash: extended_rename_hash,
        )
      end
    end

    def extended_rename_hash
      rename_hash.merge(
        value_column_name => 'value',
        'provider_id' => 'socrata_provider_id',
      )
    end
  end
end
