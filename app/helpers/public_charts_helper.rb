# Providers helper methods for PublicChartsController's templates
module PublicChartsHelper
  BACK_CONTROLLERS = {
    true => :charts_root,
    false => :public_charts,
  }

  def back_button_options(node)
    controller = BACK_CONTROLLERS.fetch(node.parent_is_root?)
    url_options = {
      controller: controller,
      action: :show,
      only_path: true,
    }
    url_options[:id] = node.parent_id unless node.parent_is_root?
    url_options
  end

  def parent_link_text(node)
    if node.parent_is_root?
      'Metrics'
    else
      node.parent_short_title
    end
  end
end
