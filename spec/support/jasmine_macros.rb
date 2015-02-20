require_relative './jasmine_test_helpers'

# Build jasmine fixtures in the rspec classes (like 'describe' blocks)
module JasmineMacros
  def self.extended(base)
    base.include JasmineTestHelpers
  end

  def save_fixture(name = nil, &block)
    it 'saves the fixture' do
      stub_current_user
      instance_eval(&block) if block_given?
      save_fixture(name)
    end
  end
end
