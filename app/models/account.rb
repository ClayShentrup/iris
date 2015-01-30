# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_hospital_id :integer          not null
#  virtual_system_id   :integer          not null
#  virtual_system_type :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Account < ActiveRecord::Base
  belongs_to :virtual_system, polymorphic: true
  has_one :hospital
  has_many :users

  delegate :name,
           :hospitals,
           to: :virtual_system
end
