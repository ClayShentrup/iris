require 'test_helper'
require 'rails/performance_test_help'
require 'rails/perftest/action_dispatch/performance_test'

# Pristine Examples performance tests
class PristineExamplesTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test 'index' do
    get '/pristine_examples'
  end
end
