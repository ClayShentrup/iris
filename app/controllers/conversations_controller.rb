# Controller for conversations related to a chart
class ConversationsController < ApplicationController
  layout false

  def create
    @conversation =
      Conversation.new(allowed_params.merge(
                         author: current_user,
                         provider: current_user.selected_provider,
                      ))
    flash_success_message('created') if @conversation.save
    respond_with @conversation,
                 status: :unprocessable_entity if @conversation.errors
  end

  private

  def allowed_params
    params.require(:conversation).permit(
      :title, :description, :node_id_component
    )
  end
end
