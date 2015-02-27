module Socrata
  module Datasets
    # A Socrata endpoint. See https://data.medicare.gov/
    module HospitalValueBasedPurchasing
      DATASET_ID = 'ypbt-wvdk'
      DATASET_TYPE = :SingleMeasure
      PROVIDER_ID_COLUMN_NAME = 'provider_number'
    end
  end
end
