# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  provider_id :integer
#  author_id   :integer
#  measure_id  :string           not null
#  title       :string           not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
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
      before { subject.skip_association_presence_validations = false }
      it { is_expected.to validate_presence_of(:author) }
      it { is_expected.to validate_presence_of(:provider) }
    end

    it { is_expected.to validate_presence_of(:measure_id) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end

  describe 'delegations' do
    it do
      is_expected.to delegate_method(:author_account)
        .to(:author)
        .as(:account)
    end
  end

  it { is_expected.to belong_to(:author).class_name('User') }
  it { is_expected.to belong_to :provider }

  it { is_expected.to have_many :agreements }

  describe 'data methods' do
    let(:relevant_provider) { build_stubbed Provider }
    let(:other_provider) { build_stubbed Provider }
    let(:relevant_account) { create Account }
    let(:other_account) { create Account }

    let(:relevant_account_author) do
      create(User, account: relevant_account)
    end
    let(:relevant_account_current_user) do
      create(
        User,
        account: relevant_account,
        selected_provider: relevant_provider,
      )
    end
    let(:viewer_for_different_account) do
      create(User, account: other_account)
    end

    let(:relevant_measure_id) { 'patient-safety-composite' }
    let(:other_measure_id) { 'infarction' }

    let(:valid_attributes) do
      {
        provider: relevant_provider,
        author: relevant_account_author,
        measure_id: relevant_measure_id,
      }
    end

    def create_conversation(attributes)
      create(Conversation, valid_attributes.merge(attributes))
    end

    let!(:relevant_conversation_1) do
      create_conversation(created_at: 5.days.ago)
    end
    let!(:relevant_conversation_2) do
      create_conversation(
        author: relevant_account_current_user,
        created_at: 2.days.ago,
      )
    end

    let!(:conversation_for_different_provider) do
      create_conversation(provider: other_provider)
    end

    let!(:conversation_for_different_account) do
      create_conversation(author: viewer_for_different_account)
    end

    let!(:conversation_for_different_node) do
      create_conversation(measure_id: other_measure_id)
    end

    def data
      described_class.for_chart(
        relevant_measure_id,
        relevant_account_current_user,
      )
    end

    it 'returns the correct conversations' do
      expect(data).to eq [
        relevant_conversation_2,
        relevant_conversation_1,
      ]
    end
  end
end
