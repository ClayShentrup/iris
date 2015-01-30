# This file should contain all the record creation needed to seed the database
#   with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
#   db with db:setup).
User.destroy_all # Clear out model(s) being seeded.

User.reset_column_information

user = User.new(
  email: 'eng-service@dabohealth.com',
  password: 'timeandcolorisblue',
)
user.skip_confirmation!
user.save!
