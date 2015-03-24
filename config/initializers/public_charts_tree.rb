PUBLIC_CHARTS_TREE = PublicChartsTree.new do
  measure_source 'Public Data' do
    metric_module 'Hospital-Acquired Conditions' do
      value Socrata::DimensionSampleManagers::GraphDataPoints::
        ProviderAggregate.new(
          value_column_name: :total_hac_score,
          dataset_id: 'yq43-i98g',
        )
      domain 'Patient Safety Indicator' do
        value Socrata::DimensionSampleManagers::GraphDataPoints::
        ProviderAggregate.new(
          value_column_name: :domain_1_score,
          dataset_id: 'yq43-i98g',
        )
        measures :PSI_90_SAFETY
      end
      domain 'Hospital Acquired Infection' do
        value Socrata::DimensionSampleManagers::GraphDataPoints::
        ProviderAggregate.new(
          value_column_name: :domain_2_score,
          dataset_id: 'yq43-i98g',
        )
        measures :HAI_1_SIR,
                 :HAI_2_SIR
      end
    end
    metric_module 'Readmissions Reduction Program' do
      measures :READM_30_AMI,
               :READM_30_HF,
               :READM_30_PN,
               :READM_30_COPD,
               :READM_30_HIP_KNEE
    end
    metric_module 'Hospital Consumer Assessment of Healthcare Providers and ' \
      'Systems' do
      category 'Communication' do
        measures :H_COMP_1_A_P,
                 :H_COMP_2_A_P,
                 :H_COMP_3_A_P
      end
      category 'Pain Management' do
        measures :H_COMP_4_A_P
      end
      category 'Medications' do
        measures :H_COMP_5_A_P
      end
      category 'Discharge Information' do
        measures :H_COMP_6_Y_P
      end
      category 'Care Transition' do
        measures :H_COMP_7_SA
      end
      category 'Environment' do
        measures :H_CLEAN_HSP_A_P,
                 :H_QUIET_HSP_A_P
      end
      category 'Overall Rating' do
        measures :H_HSP_RATING_9_10
      end
      category 'Recommendation' do
        measures :H_RECMND_DY
      end
    end
  end
end
