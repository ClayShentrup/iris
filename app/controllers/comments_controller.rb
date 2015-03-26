# Controller to handle comments for conversations
class CommentsController < ApplicationController
  layout false

  def create
    @comment = Comment.new(allowed_params.merge(author: current_user))

    flash_success_message('created') if @comment.save
    respond_with @comment,
                 status: :unprocessable_entity if @comment.errors
  end

  private

  def allowed_params
    params.require(:comment).permit(
      :content, :conversation_id
    )
  end
end
