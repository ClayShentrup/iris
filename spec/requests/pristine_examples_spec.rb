require 'rails_helper'

RSpec.describe 'PristineExamples' do
  describe 'GET /pristine_examples' do
    it 'works! (now write some real specs)' do
      get pristine_examples_path
      expect(response.status).to be(200)
    end
  end
end
