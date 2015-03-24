require 'devise/version'

RSpec.describe 'Devise version' do
  it 'is 3.4.1' do
    # Reminder to update the Users::RegistrationsController once Devise is
    # updated and the build_resource method override is no longer necessary
    expect(Devise::VERSION).to eq '3.4.1'
  end
end
