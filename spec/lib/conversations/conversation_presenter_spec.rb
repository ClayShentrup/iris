require 'active_record_no_rails_helper'
require 'conversations/conversation_presenter'

RSpec.describe Conversations::ConversationPresenter do
  let(:conversation) { instance_double('Conversation') }
  let(:comment) { build_stubbed(Comment, author: user) }
  let(:subject) do
    described_class.new(user, node_id_component)
  end
  let(:user) { build_stubbed(User, :with_associations) }
  let(:node_id_component) { 'patient-safety-composite' }

  before do
    allow(Conversation).to receive(:new).and_return(conversation)
  end

  describe '#new_conversation' do
    it 'returns a new instance of Conversation' do
      expect(described_class.new.new_conversation).to be(conversation)
    end
  end

  describe '#author_name' do
    let(:author_name) { "#{user.first_name} #{user.last_name}" }
    it 'returns the author\'s full name' do
      expect(subject.author_name(comment)).to eq(author_name)
    end
  end

  describe '#chart_conversations' do
    let(:conversations) { ['Conversation 1', 'Conversation 2'] }

    before do
      allow(Conversation).to receive(:for_chart).and_return(conversations)
    end

    it 'returns a list of conversations for a chart' do
      expect(subject.chart_conversations).to eq conversations
    end
  end
end
