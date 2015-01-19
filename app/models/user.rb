# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# An entity to log into the system
class User < ActiveRecord::Base
  validates :email, presence: true
end
