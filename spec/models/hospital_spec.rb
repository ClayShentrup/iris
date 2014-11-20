require "rails_helper"

describe Hospital do
  it "should have core hospital info" do
    h = Hospital.create(
      :name => 'fake hospital',
      :zip_code => '94114',
      :hospital_type => 'fake hospital type',
      :provider_id => '010001',
      :state => 'CA',
      :city => 'fake city'
    )

    h = Hospital.first

    expect(h.name).to eq('fake hospital')
    expect(h.zip_code).to eq(94114)
    expect(h.hospital_type).to eq('fake hospital type')
    expect(h.provider_id).to eq('010001')
    expect(h.state).to eq('CA')
    expect(h.city).to eq('fake city')
  end
end

