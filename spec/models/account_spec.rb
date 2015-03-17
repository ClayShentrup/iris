# == Schema Information
#
# Table name: accounts
#
#  id                  :integer          not null, primary key
#  default_provider_id :integer          not null
#  virtual_system_id   :integer          not null
#  virtual_system_type :string           not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/account'

RSpec.describe Account, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:default_provider) }
    it { is_expected.to validate_presence_of(:virtual_system) }
  end

  it { is_expected.to belong_to :virtual_system }
  it { is_expected.to belong_to :default_provider }
  it { is_expected.to have_many(:users) }
  it { is_expected.to have_many :purchased_metric_modules }
  it { is_expected.to have_many(:authorized_domains) }
end
