# View helpers that should be available application-wide.
module ApplicationHelper
  def controller_action_name
    [
      controller_name,
      rendered_action,
    ].join('-')
  end

  def current_user_id
    current_user.try(:id) || 'null'
  end

  private

  def rendered_action
    @rendered_action || action_name
  end
end
