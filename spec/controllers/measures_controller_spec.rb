require 'rails_helper'

RSpec.describe MeasuresController do
  describe 'GET show' do
    before do
      get :show, id: '1'
    end

    it 'renders the show template' do
      expect(response).to render_template('show')
    end

    it 'renders measure title' do
      expect(response.body).to include('Communication with Nurses')
    end

    it 'renders measure description' do
      expect(response.body).to include('Percent of patients who reported that '\
        'their nurses "Always" communicated well')
    end
  end
end
