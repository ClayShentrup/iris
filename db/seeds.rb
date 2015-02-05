# This file should contain all the record creation needed to seed the database
#   with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
#   db with db:setup).

USERS = [
  {
    email: 'admin@dabohealth.com',
    password: 'timeandcolorisblue',
    is_dabo_admin: true,
  },
  {
    email: 'plebe@dabohealth.com',
    password: 'timeandcolorisblue',
    is_dabo_admin: true,
  },
]

HOSPITALS = [
  {
    name: 'Dabo Hospital Bel Air',
    # TODO: is hospital provider id based on hospital or system?
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
]

HOSPITAL_SYSTEMS = [
  {
    name: 'Dabo Health System',
  },
]
User.create!(USERS) do |user|
  user.skip_confirmation!
end

HospitalSystem.create!(HOSPITAL_SYSTEMS)
Hospital.create!(HOSPITALS) do |hospital|
  hospital.hospital_system = HospitalSystem.find_by_name('Dabo Health System')
end
