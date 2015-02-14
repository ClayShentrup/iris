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

HospitalSystem.create!(name: 'Dabo Health System')

Hospital.create!(
  [
    {
      name: 'Dabo Hospital Bel Air',
      provider_id: '999999',
      city: 'Bel Air',
      state: 'CA',
      zip_code: '90077',
      hospital_type: 'Bourgeois',
    },
    {
      name: 'Dabo Hospital West Philly',
      provider_id: '999998',
      city: 'Philadelphia',
      state: 'PA',
      zip_code: '19019',
      hospital_type: 'Playground',
    },
  ],
) do |hospital|
  hospital.hospital_system = HospitalSystem.find_by!(name: 'Dabo Health System')
end
