require 'rails_helper'

RSpec.describe StatusesController do
  describe 'GET show' do
    context 'with a database connection' do
      it 'returns with database_status OK' do
        get :show
        expect(response.body).to include('{"database_status":"OK"}')
      end
    end

    context 'without a database connection' do
      it 'returns with database_status Not OK' do
        allow(controller).to receive(:can_connect_to_db?).and_return(false)
        get :show
        expect(response.body).to include('{"database_status":"Not OK"}')
      end
    end
  end
end
