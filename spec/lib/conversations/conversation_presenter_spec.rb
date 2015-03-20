require 'active_record_no_rails_helper'
require 'conversations/conversation_presenter'

RSpec.describe Conversations::ConversationPresenter do
  let(:conversation) { instance_double('Conversation') }

  before do
    allow(Conversation).to receive(:new).and_return(conversation)
  end

  describe '#new_conversation' do
    it 'returns a new instance of Conversation' do
      expect(described_class.new.new_conversation).to be(conversation)
    end
  end

  describe '#chart_conversations' do
    let(:subject) do
      described_class.new(user, node)
    end
    let(:user) { build_stubbed(User, :with_associations) }
    let(:node) { double('Node') }
    let(:conversations) { ['Comment 1', 'Comment 2'] }

    before do
      allow(described_class).to receive(:new)
        .with(user, node).and_return(subject)
      allow(node).to receive(:id_component)
      allow(Conversation).to receive(:for_chart).and_return(conversations)
    end

    it 'returns a list of conversations for a chart' do
      expect(subject.chart_conversations).to eq conversations
    end
  end
end
