# Providers helper methods for PublicChartsController's templates
module PublicChartsHelper
  BACK_CONTROLLERS = {
    true => :charts_root,
    false => :public_charts,
  }

  def back_button_options(node)
    back_is_charts_root = node.type == 'measure_source'
    controller = BACK_CONTROLLERS.fetch(back_is_charts_root)
    url_options = {
      controller: controller,
      action: :show,
      only_path: true,
    }
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
      socrata_provider_id: provider.id,
      provider_name: provider.name,
      provider_city_and_state: provider.city_and_state,
    }
  end
end
