require 'rspec/expectations'

# Asserts that average real time that takes to execute the block is
# less than +expected+ time in ms.
# Receives an optional +options+ hash as second argument
#
# ==== Options
#
# * <tt>:runs</tt> - Number of times to execute the bock
#   (defaults to RSpec.configuration.default_performance_runs).
#
# ==== Example
#   expect { get :index }.to take_less_than(15, runs: 3)
#
RSpec::Matchers.define :take_less_than do |expected, options|
  options ||= {}

  match do |action|
    run_warmup action
    @actual = 0
    runs.times { @actual += Benchmark.realtime { action.call } }
    @actual = @actual * 1000 / runs
    @actual < expected
  end

  failure_message do
    "expected action to take less than #{expected}ms, but took #{@actual}ms"
  end

  def run_warmup(action)
    action.call
    GC.start
  end

  define_method :runs do
    options.fetch(:runs, RSpec.configuration.default_performance_runs)
  end

  supports_block_expectations
end
