require 'rails_helper'

describe Api::HospitalsController do
  describe "index" do
    before do
      Hospital.create(
        :name => 'one hospital',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
        :state => 'CA',
        :city => 'SOME CITY'
      )

      Hospital.create(
        :name => 'old name',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
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
  end
end
