# This is a file to load dependencies needed by *anything* that tests Rails,
# e.g. ordinary specs that use rails_helper and therefore load Rails, as well as
# isolated active_record specs that don't load the entire Rails app.
# In principle, this would apply to any other components of Rails that we can
# test in isolation, such as ActiveJob.
require 'shoulda/matchers'
