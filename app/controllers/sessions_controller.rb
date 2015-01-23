# This class overrides default sessions controller in Devise to configure
# the layout to be used in the login in page
class SessionsController < Devise::SessionsController
  layout 'login'
end
