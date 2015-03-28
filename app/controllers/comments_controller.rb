# Controller to handle comments for conversations
class CommentsController < ApplicationController
  layout false

  def create
    @comment = Comment.new(allowed_params.merge(author: current_user))
    if @comment.save
      flash_success_message('created')
      redirect_to conversations_path(
        node_id_component: @comment.conversation_node_id_component,
      )
    else
      @conversation_presenter = Conversations::ConversationPresenter.new(
        current_user,
        @comment.conversation_node_id_component,
      )
      render :new, status: :unprocessable_entity
    end
  end

  private

  def allowed_params
    params.require(:comment).permit(
      :content, :conversation_id
    )
  end
end
