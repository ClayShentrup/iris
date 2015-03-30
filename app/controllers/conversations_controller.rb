# Controller for conversations related to a chart
class ConversationsController < ApplicationController
  layout false

  def index
    @conversation_presenter = Conversations::ConversationPresenter.new(
      current_user,
      params.fetch(:measure_id),
    )
  end

  def create
    @conversation = Conversation.new(allowed_params_with_user_data)

    if @conversation.save
      flash_success_message('created')
      redirect_to conversations_path(
        measure_id: @conversation.measure_id,
      )
    else
      @conversation_presenter = Conversations::ConversationPresenter.new(
        current_user,
        @conversation.measure_id,
      )
      render :new, status: :unprocessable_entity
    end
  end

  def show
    super
    @conversation_presenter = Conversations::ConversationPresenter.new(
      current_user,
      @conversation.measure_id,
    )

    @new_comment = Comment.new(conversation: @conversation)
  end

  private

  def allowed_params_with_user_data
    allowed_params.merge(
      author: current_user,
      provider: current_user.selected_provider,
    )
  end

  def allowed_params
    params.require(:conversation).permit(
      :title, :description, :measure_id
    )
  end
end
