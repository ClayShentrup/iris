require 'rails_helper'
require 'support/shared_examples/json_controller'

RSpec.describe Api::HospitalsController do
  it_behaves_like 'a controller which ensures a JSON request'

  describe "index" do
    before do
      FactoryGirl.create(:hospital,
        :name => 'one hospital',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
        :state => 'CA',
        :city => 'SOME CITY'
      )

      FactoryGirl.create(:hospital,
        :name => 'old name',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :state => 'CA',
        :city => 'SOME CITY'
      )
    end

    it "returns the right hospital" do
      get :index, :format => :json, :q => 'hospital'

      expect(assigns(:hospitals).size).to eq(1)
      expect(assigns(:hospitals).first.provider_id).to eq('some provider id')
    end

    it "returns everything if correct query param is not set" do
      get :index, :format => :json

      expect(assigns(:hospitals).map(&:provider_id)).to eq(Hospital.all.map(&:provider_id))
    end

    it "returns an empty response if nothing is found" do
      get :index, :format => :json, :q => 'something random'

      expect(assigns(:hospitals)).to eq([])
    end

    it 'fails with an HTML request' do
      get :index, q: 'some query'
    end
  end
end
