# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'active_record_spec_helper'
require './app/models/user'

RSpec.describe User, type: :model do
  describe 'columns' do
    it { should have_db_column(:email).of_type(:string) }
  end

  describe 'validating' do
    it { should validate_presence_of(:email) }
  end
end
