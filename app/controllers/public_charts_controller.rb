# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  def show
    persist_selected_provider

    @node = PUBLIC_CHARTS_TREE.find_node(
      params.fetch(:id),
      providers: default_providers_relation,
    )

    @provider_compare_presenter =
      Providers::ProviderComparePresenter.new(selected_provider)
    @custom_feedback_bar = true
  end

  private

  def default_providers_relation
    Provider.in_same_city(selected_provider)
  end

  def selected_provider
    user_selected_provider || default_provider
  end

  def user_selected_provider
    Provider.find_by_id(current_user.selected_provider_id)
  end

  def default_provider
    Provider.new(
      name: 'SAN FRANCISCO GENERAL HOSPITAL',
      zip_code: '94110',
      hospital_type: 'Acute Care Hospitals',
      socrata_provider_id: '050228',
      state: 'CA',
      city: 'SAN FRANCISCO',
      hospital_system_id: 115,
    )
  end

  def persist_selected_provider
    return unless params.fetch(:provider_id, nil)
    current_user.settings.selected_provider_id = params.fetch(:provider_id, nil)
    current_user.save!
  end
end
