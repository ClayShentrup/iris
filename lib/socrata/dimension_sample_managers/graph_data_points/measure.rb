require './app/models/dimension_sample/measure'
require_relative '../../dimension_sample_importer'
require_relative '../../simple_soda_client_base'

module Socrata
  module DimensionSampleManagers
    module GraphDataPoints
      # Satisfies the GraphDataPoint DimensionSampleManager interface to
      # retrieve and refresh data.
      class Measure
        MEASURE_ID_TO_DATASET = {
          '7xux-kdpw' => [
            :PSI_90_SAFETY,
            :READM_30_AMI,
            :READM_30_HF,
            :READM_30_PN,
            :READM_30_COPD,
            :READM_30_HIP_KNEE,
          ],

          '77hc-ibv8' => [
            :HAI_1_SIR,
            :HAI_2_SIR,
          ],

          'dgck-syfz' => [
            :H_COMP_1_A_P,
            :H_COMP_2_A_P,
            :H_COMP_3_A_P,
            :H_COMP_4_A_P,
            :H_COMP_5_A_P,
            :H_COMP_6_Y_P,
            :H_COMP_7_SA,
            :H_CLEAN_HSP_A_P,
            :H_QUIET_HSP_A_P,
            :H_HSP_RATING_9_10,
            :H_RECMND_DY,
          ],
        }
        DATASET_TO_VALUE_COLUMN_NAME = {
          '7xux-kdpw' => :score,
          '77hc-ibv8' => :score,
          'dgck-syfz' => :hcahps_answer_percent,
        }
        DATASET_TO_BEST_VALUE_METHOD = {
          'dgck-syfz' => :maximum,
          '7xux-kdpw' => :minimum,
          '77hc-ibv8' => :minimum,
        }
        MODEL_CLASS = DimensionSample::Measure

        # .
        module ValueColumnManager
          def self.rename_hash
            {}
          end

          def self.measure_id_column_name
            'measure_id'
          end
        end

        # .
        module HcahpsValueColumnManager
          def self.rename_hash
            { 'hcahps_measure_id' => 'measure_id' }
          end

          def self.measure_id_column_name
            'hcahps_measure_id'
          end
        end

        delegate :rename_hash, :measure_id_column_name, to: :column_manager

        def initialize(measure_id:)
          @measure_id = measure_id
        end

        def data(providers)
          DimensionSample::Measure.data(
            measure_id: @measure_id,
            providers: providers,
          )
        end

        def import
          DimensionSampleImporter.call(
            dimension_samples: dimension_samples,
            model_attributes: base_options,
            model_class: MODEL_CLASS,
            rename_hash: rename_hash,
            value_column_name: value_column_name,
          )
        end

        def subtitle
        end

        def national_best_performer_value
          MODEL_CLASS.where(base_options).public_send(best_value_method, :value)
        end

        private

        def best_value_method
          DATASET_TO_BEST_VALUE_METHOD.fetch(dataset_id)
        end

        def column_manager
          if hcahps_measure?
            HcahpsValueColumnManager
          else
            ValueColumnManager
          end
        end

        def dimension_samples
          SimpleSodaClientBase.call(
            dataset_id: dataset_id,
            required_columns: required_columns,
            extra_query_options: {
              '$where' => "#{measure_id_column_name} = '#{@measure_id}'",
            },
          )
        end

        def required_columns
          [
            :provider_id,
            value_column_name,
          ]
        end

        def hcahps_measure?
          dataset_id == 'dgck-syfz'
        end

        def base_options
          { measure_id: @measure_id }
        end

        def dataset_id
          MEASURE_ID_TO_DATASET.keys.find do |key|
            MEASURE_ID_TO_DATASET.fetch(key).include?(@measure_id)
          end
        end

        def value_column_name
          DATASET_TO_VALUE_COLUMN_NAME.fetch(dataset_id)
        end
      end
    end
  end
end
