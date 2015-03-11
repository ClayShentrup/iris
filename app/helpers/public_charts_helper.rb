# Providers helper methods for PublicChartsController's templates
module PublicChartsHelper
  BACK_URL_OPTIONS = {
    true => {
      controller: :data_categories,
      action: :index,
    },
    false => {
      controller: :public_charts,
      action: :show,
    },
  }

  def back_button_options(node)
    back_is_charts_root = node.type == 'measure_source'
    url_options = BACK_URL_OPTIONS.fetch(back_is_charts_root)
                  .merge(only_path: true)
    url_options[:id] = node.parent_id unless back_is_charts_root
    url_options
  end

  def node_link(node)
    link_to(
      node.short_title,
      controller: :public_charts,
      action: :show,
      id: node.id,
      only_path: true,
    )
  end

  def provider_data_attributes(provider)
    {
      provider_id: provider.id,
      provider_name: provider.name,
      provider_city_and_state: provider.city_and_state,
    }
  end
end
