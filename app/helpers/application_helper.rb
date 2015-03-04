# View helpers that should be available application-wide.
module ApplicationHelper
  def controller_action_name
    [
      controller_name,
      rendered_action,
    ].join('-')
  end

  def last_sign_on
    current_user.current_sign_in_at.strftime('%d-%b-%Y %H:%M %Z').upcase
  end

  private

  def rendered_action
    @rendered_action || action_name
  end
end
