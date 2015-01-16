# == Schema Information
#
# Table name: pristine_examples
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

# An example of a minimal, well tested CRUD model
class PristineExample < ActiveRecord::Base
  validates :name, presence: true
end
