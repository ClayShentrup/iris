# .
module Constraints
  # Only allow authenticated admins access to precious resources.
  DaboAdmin = Struct.new(:request) do
    def self.matches?(request)
      new(request).matches?
    end

    def matches?
      warden.authenticated? && warden.user.is_dabo_admin?
    end

    private

    def warden
      request.env.fetch('warden')
    end
  end
end
