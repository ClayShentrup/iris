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
  has_one :default_hospital_id
  has_many :hospitals
  has_many :users

  delegate :name,
           to: :virtual_system
end
