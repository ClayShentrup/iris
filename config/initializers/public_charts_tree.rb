PUBLIC_CHARTS_TREE = PublicChartsTree.new do
  measure_source 'Public Data' do
    bundle 'Value Based Purchasing' do
      domain 'Outcome of Care' do
        value DimensionSampleManagers::Socrata.new(
          dataset: :HospitalValueBasedPurchasing,
          options: { column_name: :weighted_outcome_domain_score },
        )
        category 'Mortality' do
          measures :MORT_30_HF,
                   :MORT_30_AMI,
                   :MORT_30_PN
        end
        category 'Patient Safety Indicator' do
          measures :PSI_90
        end
        category 'Central Line Associated Bloodstream Infection' do
          measures :HAI_1_SIR
        end
      end
      domain 'Process of Care' do
        value DimensionSampleManagers::Socrata.new(
          dataset: :HospitalValueBasedPurchasing,
          options: {
            column_name: :weighted_clinical_process_of_care_domain_score,
          },
        )
        category 'Heart Failure' do
          measures :HF_1
        end
        category 'Surgical Care Improvement Project' do
          measures :SCIP_INF_1,
                   :SCIP_INF_2,
                   :SCIP_INF_3,
                   :SCIP_INF_4,
                   :SCIP_INF_9,
                   :SCIP_CARD_2,
                   :SCIP_VTE_2
        end
        category 'Acute Myocardial Infarction' do
          measures :AMI_7a,
                   :AMI_8a
        end
      end
      domain 'Patient Experience of Care' do
        value DimensionSampleManagers::Socrata.new(
          dataset: :HospitalValueBasedPurchasing,
          options: {
            column_name: :weighted_patient_experience_of_care_domain_score,
          },
        )
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
        category 'Environment' do
          measures :H_CLEAN_HSP_A_P,
                   :H_QUIET_HSP_A_P
        end
        category 'Discharge Information' do
          measures :H_COMP_6_Y_P
        end
        category 'Overall Rating' do
          measures :H_HSP_RATING_9_10
        end
      end
      domain 'Efficiency of Care' do
        value DimensionSampleManagers::Socrata.new(
          dataset: :HospitalValueBasedPurchasing,
          options: { column_name: :weighted_efficiency_domain_score },
        )
        measures :MSPB_1
      end
    end
    bundle 'Hospital-Acquired Conditions' do
      value DimensionSampleManagers::Socrata.new(
          dataset: :HacReductionProgram,
          options: { column_name: :total_hac_score },
      )
      domain 'Patient Safety Indicator' do
        value DimensionSampleManagers::Socrata.new(
          dataset: :HacReductionProgram,
          options: { column_name: :domain_1_score },
        )
        measures :PSI_90
      end
      domain 'Hospital Acquired Infection' do
        value DimensionSampleManagers::Socrata.new(
          dataset: :HacReductionProgram,
          options: { column_name: :domain_2_score },
        )
        measures :HAI_1_SIR,
                 :HAI_2_SIR
      end
    end
    bundle 'Readmissions Reduction Program' do
      measures :READM_30_AMI,
               :READM_30_HF,
               :READM_30_PN,
               :READM_30_COPD,
               :READM_30_HIP_KNEE
    end
    bundle 'Hospital Consumer Assessment of Healthcare Providers and Systems' do
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
    bundle 'Surgical Care Improvement Project' do
      category 'Timely Surgical Care' do
        measures :OP_6,
                 :SCIP_INF_1,
                 :SCIP_INF_3,
                 :SCIP_VTE_2
      end
      category 'Effective Surgical Care' do
        measures :OP_7,
                 :SCIP_CARD_2,
                 :SCIP_INF_2,
                 :SCIP_INF_4,
                 :SCIP_INF_9,
                 :SCIP_INF_10
      end
    end
  end
end
