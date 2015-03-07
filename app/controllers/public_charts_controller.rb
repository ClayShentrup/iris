# "public charts" are charts comprised of static measures such as those set by
# CMS. They are not customizable for a client, thus they are not backed by
# dynamic data, e.g. in the database.
class PublicChartsController < ApplicationController
  def show
    @node = PUBLIC_CHARTS_TREE.find_node(
      params.fetch(:id),
      providers: providers,
    )
    @provider_compare_presenter =
      Providers::ProviderComparePresenter.new(default_provider)
    @custom_feedback_bar = true
  end

  private

  def providers
    Provider.limit(5)
  end

  def default_provider
    selected_provider || initial_provider
  end

  def selected_provider
    Provider.find_by_id(current_user.settings.selected_provider_id)
  end

  def initial_provider
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
end
