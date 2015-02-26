# This file should contain all the record creation needed to seed the database
# with its default values for development and acceptance environments.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:reset).

User.create!(
  [
    {
      email: 'admin@dabohealth.com',
      password: 'timeandcolorisblue',
      is_dabo_admin: true,
    },
    {
      email: 'plebe@dabohealth.com',
      password: 'timeandcolorisblue',
      is_dabo_admin: false,
    },
  ],
  &:skip_confirmation!
)

hospital_system = HospitalSystem.create!(name: 'Mayo Health System')

hospitals = Hospital.create!(
  [
    {
      name: 'MAYO CLINIC HOSPITAL',
      zip_code: '85054',
      hospital_type: 'Acute Care Hospitals',
      provider_id: '030103',
      state: 'AZ',
      city: 'PHOENIX',
    },
    {
      name: 'MAYO CLINIC',
      zip_code: '32224',
      hospital_type: 'Acute Care Hospitals',
      provider_id: '100151',
      state: 'FL',
      city: 'JACKSONVILLE',
    },
  ],
) do |hospital|
  hospital.hospital_system = hospital_system
end

DimensionSample::SingleMeasure.create!(
  [
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_outcome_domain_score',
      value: '17.127',
      provider_id: hospitals.fetch(0).provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_outcome_domain_score',
      value: '27.128',
      provider_id: hospitals.fetch(1).provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_clinical_process_of_care_domain_score',
      value: '15.133',
      provider_id: hospitals.fetch(0).provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_efficency_domain_score',
      value: '9.031',
      provider_id: hospitals.fetch(0).provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_patient_experience_of_care_score',
      value: '8.462',
      provider_id: hospitals.fetch(1).provider_id,
    },
  ],
)
