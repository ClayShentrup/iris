# == Schema Information
#
# Table name: conversations
#
#  id                :integer          not null, primary key
#  provider_id       :integer
#  user_id           :integer
#  node_component_id :string           not null
#  title             :string           not null
#  description       :text             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/conversation'

RSpec.describe Conversation do
  subject { build_stubbed(described_class) }

  describe 'columns' do
    it do
      is_expected.to have_db_column(:title).of_type(:string)
        .with_options(null: false)
    end
    it do
      is_expected.to have_db_column(:description).of_type(:text)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    it do
      is_expected.to be_valid
    end

    describe 'associations' do
      before { subject.skip_association_validations = false }
      it { is_expected.to validate_presence_of(:user) }
      it { is_expected.to validate_presence_of(:provider) }
    end

    it { is_expected.to validate_presence_of(:node_component_id) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'delegations' do
    it do
      is_expected.to delegate_method(:user_account)
        .to(:user)
        .as(:account)
    end
  end

  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :provider }
end
