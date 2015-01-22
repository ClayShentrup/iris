# Providers helper methods for PublicChartsController's templates
module PublicChartsHelper
  BACK_CONTROLLERS = {
    true => :charts_root,
    false => :public_charts,
  }

  def back_button_options(parent_id)
    parent_is_root = parent_id.blank?
    controller = BACK_CONTROLLERS.fetch(parent_is_root)
    url_options = {
      controller: controller,
      action: :show,
      only_path: true,
    }
    url_options[:id] = parent_id unless parent_is_root
    url_options
  end
end
