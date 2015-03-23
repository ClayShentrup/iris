MEASURES = {
  PSI_90_SAFETY: {
    short_title: 'Patient Safety Composite',
    value: DimensionSampleManagers::Socrata.new(
      column_name: :score,
      dataset_id: '7xux-kdpw',
      measure_id: 'PSI_90_SAFETY',
    ),
  },
  HAI_1_SIR: {
    short_title: 'Catheter Associated Urinary Tract Infection',
    value: DimensionSampleManagers::Socrata.new(
      column_name: :score,
      dataset_id: '77hc-ibv8',
      measure_id: 'HAI_1_SIR',
    ),
  },
  HAI_2_SIR: {
    short_title: 'Central Line Associated Bloodstream Infection',
  },
  H_COMP_1_A_P: {
    short_title: 'Communication with Nurses',
  },
  H_COMP_2_A_P: {
    short_title: 'Communication with Doctors',
  },
  H_COMP_3_A_P: {
    short_title: 'Responsiveness of hospital staff',
  },
  H_COMP_4_A_P: {
    short_title: 'Pain Management',
  },
  H_COMP_5_A_P: {
    short_title: 'Communication about Medications',
  },
  H_COMP_6_Y_P: {
    short_title: 'Discharge Information',
  },
  H_COMP_7_SA: {
    short_title: 'Care Transition',
  },
  H_CLEAN_HSP_A_P: {
    short_title: 'Cleanliness of Hospital Environment',
  },
  H_QUIET_HSP_A_P: {
    short_title: 'Quietness of Hospital Environment',
  },
  H_HSP_RATING_9_10: {
    short_title: 'Overall rating of hospital',
  },
  READM_30_AMI: {
    short_title: 'Acute Myocardial Infarction Readmission',
  },
  READM_30_HF: {
    short_title: 'Heart Failure Readmission',
  },
  READM_30_PN: {
    short_title: 'Pnuemonia Readmission',
  },
  READM_30_COPD: {
    short_title: 'Chronic Obstructive Pulmonary Disease Readmission',
  },
  READM_30_HIP_KNEE: {
    short_title: 'Hip and Knee Arthroplasty Readmission',
  },
  H_RECMND_DY: {
    short_title: 'Hospital Recommendation',
  },
}
