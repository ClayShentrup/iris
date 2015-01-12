# Require here all our custom review classes

# Review class names should have the `Review` prefix, but they are
# referred in the rails_best_practices config file with the `Check` prefix

require_relative 'avoid_send_method_review'
require_relative 'avoid_rails_env_review'
