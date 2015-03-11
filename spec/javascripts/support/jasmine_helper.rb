# Use this file to set/override Jasmine configuration options
# You can remove it if you don't need it.
# This file is loaded *after* jasmine.yml is interpreted.
#
# Example: using a different boot file.
# Jasmine.configure do |config|
#   config.boot_dir = '/absolute/path/to/boot_dir'
#   config.boot_files = lambda { ['/absolute/path/to/boot_dir/file.js'] }
# end
#
# Example: prevent PhantomJS auto install, uses PhantomJS already on your path.
Jasmine.configure do |config|
  unless ENV.key?('SKIP_FIXTURES')
    require 'thor/runner'
    success = Thor::Runner.start(['tests:save_jasmine_fixtures'])
    fail "\e[31mFixture specs failed!\e[0m" unless success
  end
  config.prevent_phantom_js_auto_install = false
end
