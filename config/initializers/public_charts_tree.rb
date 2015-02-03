PUBLIC_CHARTS_TREE = PublicChartTree.new do
  measure_source 'Public Data' do
    bundle 'Value Based Purchasing' do
      domain 'Outcome of Care' do
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
      domain 'Efficency of Care' do
        measures :MSPB_1
      end
    end
    bundle 'Hospital Acquired Conditions' do
      domain 'Patient Safety Indicator' do
        measures :PSI_90
      end
      domain 'Hospital Acquired Infection' do
        measures :HAI_1_SIR,
                 :HAI_2_SIR
      end
    end
    bundle 'Readmission' do
      measures :READM_30_AMI,
               :READM_30_HF,
               :READM_30_PN,
               :READM_30_COPD,
               :READM_30_HIP_KNEE
    end
    bundle 'HCAHPS' do
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
