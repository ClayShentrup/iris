# This file should contain all the record creation needed to seed the database
# with its default values for development and acceptance environments.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:reset).

hospital_system = HospitalSystem.create!(name: 'Mayo Health System')
providers = Provider.create!(
  [
    {
      name: 'MAYO CLINIC HOSPITAL',
      zip_code: '85054',
      hospital_type: 'Acute Care Hospitals',
      socrata_provider_id: '030103',
      state: 'AZ',
      city: 'PHOENIX',
    },
    {
      name: 'MAYO CLINIC',
      zip_code: '32224',
      hospital_type: 'Acute Care Hospitals',
      socrata_provider_id: '100151',
      state: 'FL',
      city: 'JACKSONVILLE',
    },
  ],
) do |provider|
  provider.hospital_system = hospital_system
end

account = Account.create!(
  virtual_system: hospital_system,
  default_provider: providers.first,
)

%w[
  hospital-acquired-conditions
  readmissions-reduction-program
  hospital-consumer-assessment-of-healthcare-providers-and-systems
].each do |metric_module_id|
  PurchasedMetricModule.create!(
    account_id: account.id,
    metric_module_id: metric_module_id,
  )
end

AuthorizedDomain.create!(
    account_id: account.id,
    name: 'dabohealth.com',
)

User.create!(
  [
    {
      first_name: 'Admin',
      last_name: 'Thompson',
      email: 'admin@dabohealth.com',
      password: 'timeandcolorisblue',
      is_dabo_admin: true,
    },
    {
      first_name: 'Plebe',
      last_name: 'Rodriguez',
      email: 'plebe@dabohealth.com',
      password: 'timeandcolorisblue',
      is_dabo_admin: false,
    },
  ],
) do |user|
  user.account = account
  user.skip_confirmation!
end

DimensionSample::ProviderAggregate.create!(
  [
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_outcome_domain_score',
      value: '17.127',
      socrata_provider_id: providers.fetch(0).socrata_provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_outcome_domain_score',
      value: '27.128',
      socrata_provider_id: providers.fetch(1).socrata_provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_clinical_process_of_care_domain_score',
      value: '15.133',
      socrata_provider_id: providers.fetch(0).socrata_provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_efficency_domain_score',
      value: '9.031',
      socrata_provider_id: providers.fetch(0).socrata_provider_id,
    },
    {
      dataset_id: 'ypbt-wvdk',
      column_name: 'weighted_patient_experience_of_care_score',
      value: '8.462',
      socrata_provider_id: providers.fetch(1).socrata_provider_id,
    },
  ],
)
