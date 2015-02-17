# Module for saving html fixtures for use in jasmine
module JasmineMacros
  FIXTURE_DIRECTORY = 'spec/javascripts/fixtures'

  def save_fixture(name, options = { type: :html }, &block)
    let_filename(name, options.fetch(:type))
    let_fixture_path

    before do
      allow(controller.current_user).to receive_messages(
        id: 42,
        email: 'test@test.com',
      )
    end

    it 'saves the fixture' do
      instance_eval(&block) if block
      File.write(fixture_path, response.body)
    end
  end

  def let_filename(name, type)
    let!(:filename) do
      filename = "#{self.class.example.full_description} #{name}"
                 .underscore.parameterize + '.' + type.to_s
      type == :json ? 'json/' + filename : filename
    end
  end

  def let_fixture_path
    let(:fixture_path) do
      fixture_path = File.join(Rails.root, FIXTURE_DIRECTORY, filename)
      fixture_directory = File.dirname(fixture_path)
      FileUtils.mkdir_p fixture_directory unless File.exist?(fixture_directory)
      fixture_path
    end
  end
end
