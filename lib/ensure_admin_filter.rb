# Before filter to ensure current user is a Dabo Admin.
# Otherwise, redirect to root URL
class EnsureAdminFilter
  def self.before(controller)
    controller.redirect_to '/' unless controller.current_user.is_dabo_admin?
  end
end
