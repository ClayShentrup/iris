require 'rails_helper'

describe Api::HospitalsController do
  describe "index" do
    it "should return the right hospital" do
      h1 = Hospital.create(
        :name => 'one hospital',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
        :state => 'CA',
        :city => 'SOME CITY'
      )

      h2 = Hospital.create(
        :name => 'old name',
        :zip_code => '94114',
        :hospital_type => 'some type',
        :provider_id => 'some provider id',
        :state => 'CA',
        :city => 'SOME CITY'
      )

      get :index, :format => :json, :q => 'one'

      expect(assigns(:hospitals).size).to eq(1)
      expect(assigns(:hospitals).first.provider_id).to eq('some provider id')
    end
  end
end