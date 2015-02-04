# Module for saving html fixtures for use in jasmine
module JasmineMacros
  SPEC_DESCRIPTION = 'saves the fixture'
  FIXTURE_DIRECTORY = 'spec/javascripts/fixtures'

  def save_fixture(name, &block)
    let_filename name
    it "#{SPEC_DESCRIPTION}" do
      instance_eval(&block)

      fixture_path = File.join(Rails.root, FIXTURE_DIRECTORY, filename)
      fixture_directory = File.dirname(fixture_path)
      FileUtils.mkdir_p fixture_directory unless File.exist?(fixture_directory)
      File.write(fixture_path, response.body)
    end
  end

  def let_filename(name)
    let(:filename) do
      "#{self.class.example.full_description} #{name}"
        .underscore.parameterize + '.html'
    end
  end
end
