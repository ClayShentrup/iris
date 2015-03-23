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
      node.title,
      controller: :public_charts,
      action: :show,
      id: node.id,
      only_path: true,
    )
  end
end
