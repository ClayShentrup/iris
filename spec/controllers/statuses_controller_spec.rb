require 'rails_helper'

RSpec.describe StatusesController do
  describe 'GET show' do
    context 'with a database connection' do
      it 'returns with database_status OK' do
        get :show
        expect(response.body).to include(
          '{"database_status":"OK"}',
        )
      end
    end

    context 'with a database error' do
      it 'returns with the database error message' do
        expect(controller).to receive(:db_connect).and_raise(
          ActiveRecord::ConnectionTimeoutError,
        )
        get :show
        expect(response.body).to include(
          '{"database_status":"ActiveRecord::ConnectionTimeoutError"}',
        )
      end
    end
  end
end
