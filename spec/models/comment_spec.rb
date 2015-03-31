# == Schema Information
#
# Table name: comments
#
#  id              :integer          not null, primary key
#  content         :text             not null
#  author_id       :integer
#  conversation_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'active_record_no_rails_helper'
require './app/models/comment'

RSpec.describe Comment do
  subject { build_stubbed(described_class) }

  describe 'columns' do
    it do
      is_expected.to have_db_column(:content).of_type(:text)
        .with_options(null: false)
    end
  end

  describe 'validations' do
    it do
      is_expected.to be_valid
    end

    describe 'associations' do
      before { subject.skip_association_presence_validations = false }
      it { is_expected.to validate_presence_of(:author) }
      it { is_expected.to validate_presence_of(:conversation) }
    end

    it { is_expected.to validate_presence_of(:content) }
  end

  it { is_expected.to belong_to(:author).class_name('User') }
  it { is_expected.to belong_to :conversation }

  it { is_expected.to have_many :agreements }

  describe 'delegations' do
    specify do
      is_expected.to delegate_method(:conversation_measure_id)
        .to(:conversation)
        .as(:measure_id)
    end
  end
end
