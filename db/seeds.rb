# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.reset_column_information

user = User.find_or_initialize_by(
  email: 'eng-service@dabohealth.com',
)
user.assign_attributes(
  password: 'timeandcolorisblue',
  is_dabo_admin: true,
)
user.skip_confirmation!
user.save!
