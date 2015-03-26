# == Schema Information
#
# Table name: agreements
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  item_type  :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/agreement'

RSpec.describe Agreement do
  subject { build_stubbed(described_class) }

  describe 'columns' do
    it do
      is_expected.to have_db_column(:item_type).of_type(:string)
      is_expected.to have_db_column(:item_id).of_type(:integer)
      is_expected.to have_db_column(:user_id).of_type(:integer)
    end

    it { is_expected.to have_db_index(:item_id) }
    it { is_expected.to have_db_index(:item_type) }
    it { is_expected.to have_db_index(:user_id) }
  end

  describe 'validations' do
    it do
      is_expected.to be_valid
    end

    describe 'associations' do
      before { subject.skip_association_validations = false }
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:item) }
    end
  end
end
