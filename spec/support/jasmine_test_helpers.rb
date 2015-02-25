require 'nokogiri'
# Build jasmine fixtures in the rspec instances (like 'it' and 'before' blocks)
module JasmineTestHelpers
  FIXTURE_DIRECTORY = 'spec/javascripts/fixtures'

  def save_fixture(name = nil)
    @fixture_name = name
    body_el = extract_html_body
    content = body_el || response.body
    File.write(jasmine_fixture_path, content)
  end

  def stub_current_user
    allow(controller.current_user).to receive_messages(
      id: 42,
      email: 'test@test.com',
    )
  end

  private

  def extract_html_body
    Nokogiri::HTML(response.body).css('body').first
  end

  def jasmine_filename
    name = "#{self.class.example.full_description} #{name}"
           .underscore.parameterize
    name = @fixture_name ? name + '-' + @fixture_name : name
    name = name + '.' + jasmine_fixture_type.to_s
    jasmine_fixture_type == :json ? 'json/' + name : name
  end

  def jasmine_fixture_path
    fixture_path = File.join(
      Rails.root, FIXTURE_DIRECTORY, jasmine_filename
    )
    fixture_directory = File.dirname(fixture_path)
    FileUtils.mkdir_p fixture_directory unless File.exist?(fixture_directory)
    fixture_path
  end

  def jasmine_fixture_type
    response.content_type == 'application/json' ? :json : :html
  end
end
