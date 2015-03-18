MEASURES = {
  PSI_90_SAFETY: {
    short_title: 'Patient Safety Composite',
    long_title:  'Complication/Patient safety for selected indicators ' \
                 '(PSI-90 composite)',
    value: DimensionSampleManagers::Socrata.new(
      column_name: :score,
      dataset_id: '7xux-kdpw',
      measure_id: 'PSI_90_SAFETY',
    ),
  },
  HAI_1_SIR: {
    short_title: 'Catheter Associated Urinary Tract Infection',
    long_title:  'Central Line-Associated Bloodstream Infection (CLABSI)',
  },
  HAI_2_SIR: {
    short_title: 'Central Line Associated Bloodstream Infection',
    long_title:  'Catheter-Associated Urinary Tract Infection (CAUTI)',
  },
  H_COMP_1_A_P: {
    short_title: 'Communication with Nurses',
    long_title:  'Patients who reported that their nurses "Always" ' \
                 'communicated well',
  },
  H_COMP_2_A_P: {
    short_title: 'Communication with Doctors',
    long_title:  'Patients who reported that their doctors "Always" ' \
                 'communicated well',
  },
  H_COMP_3_A_P: {
    short_title: 'Responsiveness of hospital staff',
    long_title:  'Patients who reported that they "Always" received ' \
                 'help as soon as they wanted',
  },
  H_COMP_4_A_P: {
    short_title: 'Pain Management',
    long_title:  'Patients who reported that their pain was "Always" ' \
                 'well controlled',
  },
  H_COMP_5_A_P: {
    short_title: 'Communication about Medications',
    long_title:  'Patients who reported that staff "Always" explained ' \
                 'about medicines before giving it to them',
  },
  H_COMP_6_Y_P: {
    short_title: 'Discharge Information',
    long_title:  'Patients who reported that YES, they were given ' \
                 'information about what to do during their recovery ' \
                 'at home',
  },
  H_COMP_7_SA: {
    short_title: 'Care Transition',
    long_title:  'Patients who "Strongly Agree" they understood their ' \
                 'care when they left the hospital',
  },
  H_CLEAN_HSP_A_P: {
    short_title: 'Cleanliness of Hospital Environment',
    long_title:  'Patients who reported that their room and bathroom ' \
                 'were "Always" clean',
  },
  H_QUIET_HSP_A_P: {
    short_title: 'Quietness of Hospital Environment',
    long_title:  'Patients who reported that the area around their ' \
                 'room was "Always" quiet at night',
  },
  H_HSP_RATING_9_10: {
    short_title: 'Overall rating of hospital',
    long_title:  'Patients who gave their hospital a rating of 9 or 10 ' \
                 'on a scale from 0 (lowest) to 10 (highest)',
  },
  READM_30_AMI: {
    short_title: 'Acute Myocardial Infarction Readmission',
    long_title:  'Acute Myocardial Infarction 30-day Mortality Rate',
  },
  READM_30_HF: {
    short_title: 'Heart Failure Readmission',
    long_title:  'Heart Failure 30-day Readmission Rate',
  },
  READM_30_PN: {
    short_title: 'Pnuemonia Readmission',
    long_title:  'Pneumonia 30-day Readmission Rate',
  },
  READM_30_COPD: {
    short_title: 'Chronic Obstructive Pulmonary Disease Readmission',
    long_title:  'Chronic Obstructive Pulmonary Disease 30 day Readmission' \
                 'Rate',
  },
  READM_30_HIP_KNEE: {
    short_title: 'Hip and Knee Arthroplasty Readmission',
    long_title:  'Elective Total Hip Arthroplasty (THA) and Total Knee' \
                 'Arthroplasty (TKA) 30 Day Readmission Rate',
  },
  H_RECMND_DY: {
    short_title: 'Hospital Recommendation',
    long_title:  'Patients who reported YES, they would definitely ' \
                 'recommend the hospital',
  },
}
