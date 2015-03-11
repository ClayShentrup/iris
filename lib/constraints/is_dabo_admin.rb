# .
module Constraints
  # Only allow authenticated admins access to precious resources.
  module IsDaboAdmin
    def self.call(user)
      user.is_dabo_admin?
    end
  end
end
