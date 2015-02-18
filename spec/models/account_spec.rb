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

require 'active_record_no_rails_helper'
require './app/models/account'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:default_hospital) }
    it { is_expected.to validate_presence_of(:virtual_system) }
  end
end
