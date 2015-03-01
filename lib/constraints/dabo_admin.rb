require 'warden'

module Constraints
  # Only allow authenticated admins access.
  class DaboAdmin
    def matches?(request)
      warden(request).authenticated? && warden(request).user.is_dabo_admin?
    end

    private

    def warden(request)
      request.env['warden']
    end
  end
end
