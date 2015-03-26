# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  def show
    persist_selected_provider
    persist_selected_context

    @node = PUBLIC_CHARTS_TREE.find_node(
      params.fetch(:id),
      providers: providers_relation,
    )

    @provider_compare_presenter = Providers::ProviderComparePresenter.new(
      current_user.selected_provider,
      current_user.selected_context,
    )
    @custom_feedback_bar = true

    @conversation_presenter = Conversations::ConversationPresenter.new(
      current_user,
      @node.id_component,
    )
  end

  private

  def providers_relation
    current_user.selected_provider
      .providers_relation(current_user.selected_context).limit(10)
  end

  def persist_selected_provider
    return unless params.fetch(:provider_id, nil)
    current_user.update_attribute(
      :selected_provider_id,
      params.fetch(:provider_id),
    )
  end

  def persist_selected_context
    return unless params.fetch(:context, nil)
    current_user.update_attribute(
      :selected_context,
      params.fetch(:context),
    )
  end
end
