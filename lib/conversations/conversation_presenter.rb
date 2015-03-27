require './app/models/conversation'
require './app/models/comment'

# .
module Conversations
  # Setup new conversation form as well as load existing conversations for a
  # chart.
  ConversationPresenter = Struct.new(:current_user, :node_id_component) do
    def new_conversation
      Conversation.new
    end

    def new_comment
      Comment.new
    end

    def chart_conversations
      Conversation.for_chart(
        node_id_component,
        current_user,
      )
    end

    def author_name(subject)
      author = subject.author
      "#{author.first_name} #{author.last_name}"
    end
  end
end
