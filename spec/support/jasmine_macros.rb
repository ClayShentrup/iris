require_relative './save_jasmine_fixture'

# Build jasmine fixtures in the rspec classes (like 'describe' blocks)
module JasmineMacros
  EXAMPLE_NAME      = 'saves the fixture'
  FIXTURE_DIRECTORY = 'spec/javascripts/fixtures'

  def save_fixture(&block)
    it EXAMPLE_NAME do
      instance_eval(&block) if block_given?
      SaveJasmineFixture.call(
        response.body,
        self.class.example.full_description,
      )
    end
  end
end
