module Socrata
  module Datasets
    # A Socrata endpoint. See https://data.medicare.gov/
    module HospitalSpendingPerPatient
      DATASET_ID = 'rrqw-56er'
      DATASET_TYPE = :SingleMeasure
      PROVIDER_ID_COLUMN_NAME = :provider_id
    end
  end
end
